import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:league_butler/utils/crypto.dart';

class EncryptInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data != null) {
      options.data = {'payload': Crypto.encrypt(jsonEncode(options.data))};
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data = response.data.toString().decrypt();
    super.onResponse(response, handler);
  }
}
