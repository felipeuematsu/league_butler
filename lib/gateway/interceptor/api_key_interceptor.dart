
import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  ApiKeyInterceptor(this.apiKey);

  final String apiKey;


}