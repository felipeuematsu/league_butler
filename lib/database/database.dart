import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:league_butler/database/constants.dart';
import 'package:league_butler/database/exception/wl_database_encryption_key_exception.dart';
import 'package:league_butler/database/util/abstract_flutter_secure_storage.dart';
import 'package:league_butler/database/util/abstract_hive.dart';
import 'package:league_butler/database/util_impl/flutter_secure_storage_impl.dart';
import 'package:league_butler/database/util_impl/hive_impl.dart';

class Database {
  Database._internal();

  factory Database({
    AbstractFlutterSecureStorage? secureStorage,
    AbstractHive? hive,
  }) {
    _shared._hive = _shared._hive ?? hive ?? const HiveImpl();
    _shared._secureStorage = _shared._secureStorage ?? secureStorage ?? const FlutterSecureStorageImpl();
    return _shared;
  }

  AbstractHive? _hive;
  AbstractFlutterSecureStorage? _secureStorage;
  static late final _shared = Database._internal();
  Box? _box, _persistentBox;

  bool Function(int, int) get _strategy => (entries, deletedEntries) => deletedEntries > 50;

  Future<void> init() async {
    await _hive?.init();
    final encryptedKey = await _getEncryptedKey();
    if (encryptedKey != null) {
      final encryptionKey = base64Url.decode(encryptedKey);
      _box = await _hive?.openBox(NON_PERSISTENT_DATABASE, HiveAesCipher(encryptionKey), _strategy);
      _persistentBox = await _hive?.openBox(PERSISTENT_DATABASE, HiveAesCipher(encryptionKey), _strategy);
    } else {
      throw WLDatabaseEncryptionKeyException();
    }
  }

  Future<String?> _getEncryptedKey() async {
    final containsEncryptionKey = await _secureStorage?.containsKey(key: CRYPTO_KEY_NAME);
    if (containsEncryptionKey == false) {
      await _secureStorage?.write(key: CRYPTO_KEY_NAME, value: base64Url.encode(CRYPTO_KEY.codeUnits));
    }
    return await _secureStorage?.read(key: CRYPTO_KEY_NAME);
  }

  String _keyAsString(key) {
    if (key is Enum) {
      return key.name;
    }
    return key;
  }
  
  
  Future<T?> read<T>(key, {bool persistent = false}) async {
   
    return await (persistent ? readPersistent(_keyAsString(key)) : readNonPersistent(_keyAsString(key)));
  }

  Future<T?> readNonPersistent<T>(key) async {
    return await _box?.get(_keyAsString(key));
  }

  Future<T?> readPersistent<T>(key) async {
    return await _persistentBox?.get(_keyAsString(key));
  }

  Future<void> write(key, dynamic value, {bool persistent = false}) async {
    await (persistent ? writePersistent(_keyAsString(key), value) : writeNonPersistent(_keyAsString(key), value));
  }

  Future<void> writeNonPersistent(key, dynamic value) async {
    await _box?.put(_keyAsString(key), value);
  }

  Future<void> writePersistent(key, dynamic value) async {
    await _persistentBox?.put(_keyAsString(key), value);
  }

  Future<void> clearNonPersistent() async {
    await _box?.clear();
  }

  Future<void> close() async {
    await _box?.close();
    await _persistentBox?.close();
  }
}
