import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:league_butler/database/util/abstract_flutter_secure_storage.dart';

class FlutterSecureStorageImpl extends AbstractFlutterSecureStorage {
  const FlutterSecureStorageImpl();

  final _shared = const FlutterSecureStorage();

  @override
  Future<bool> containsKey({required String key, IOSOptions? iOptions = IOSOptions.defaultOptions, AndroidOptions? aOptions, LinuxOptions? lOptions}) =>
      _shared.containsKey(key: key, iOptions: iOptions, aOptions: aOptions, lOptions: lOptions);

  @override
  Future<String?> read({required String key, IOSOptions? iOptions = IOSOptions.defaultOptions, AndroidOptions? aOptions, LinuxOptions? lOptions}) =>
      _shared.read(key: key, iOptions: iOptions, aOptions: aOptions, lOptions: lOptions);

  @override
  Future<void> write({required String key, required String? value, IOSOptions? iOptions = IOSOptions.defaultOptions, AndroidOptions? aOptions, LinuxOptions? lOptions}) =>
      _shared.write(key: key, value: value, iOptions: iOptions, aOptions: aOptions, lOptions: lOptions);
}
