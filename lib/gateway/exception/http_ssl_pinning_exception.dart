class HttpSslPinningException implements Exception {
  HttpSslPinningException(this.message, this.baseURL);

  final String message;
  final String baseURL;
}
