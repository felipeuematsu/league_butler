import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:league_butler/gateway/util/environment_config.dart';

class Crypto {
  const Crypto._();

  static IV get _iv => IV.fromUtf8(EnvironmentConfig.cryptoIV);
  static String get _password => EnvironmentConfig.cryptoPass;
  static String get _salt => EnvironmentConfig.cryptoSalt;
  static Key get _key => Key.fromUtf8(_password)..stretch(256, salt: Uint8List.fromList(_salt.codeUnits), iterationCount: 1035);
  static late final Encrypter _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  static void init() => _encrypter;

  static String decrypt(String data) => _encrypter.decrypt(Encrypted.fromBase64(data), iv: _iv);

  static String encrypt(String data) => _encrypter.encrypt(data, iv: _iv).base64;
}

extension WLCryptoStringExt on String {
  String encrypt() => Crypto.encrypt(this);
  String decrypt() => Crypto.decrypt(this);
}