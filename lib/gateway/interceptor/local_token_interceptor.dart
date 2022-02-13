
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/main/controller/app_controller.dart';
import 'package:league_butler/utils/logger.dart';
import 'package:logger/logger.dart';

class LocalTokenInterceptor extends Interceptor {
  LocalTokenInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    final token = await Database().read<String>(DatabaseKeys.localTokenBase64);
    if (token != null) {
      logger.i('Local token: $token');
      options.headers.assign('authorization', 'Basic $token');
    } else {
      Logger().w('No local token found');
    }
    handler.next(options);

  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectTimeout) {
      final AppController controller = Get.find();
      controller.setUpClient();
    }
    handler.next(err);
  }
}