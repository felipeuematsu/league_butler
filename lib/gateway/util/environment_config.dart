class EnvironmentConfig {
  static const isLoggingEnable = bool.fromEnvironment('LOGGING_HTTP_ENABLE', defaultValue: false);
  static const isEnableSslPinning = bool.fromEnvironment('ENABLE_SSL_PINNING', defaultValue: true);
  static const String xApiKey = String.fromEnvironment('X_API_KEY');

  static const cryptoIV = String.fromEnvironment('CRYPTO_IV');
  static const cryptoPass = String.fromEnvironment('CRYPTO_PASS');
  static const cryptoSalt = String.fromEnvironment('CRYPTO_SALT');
}