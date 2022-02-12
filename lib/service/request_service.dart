import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:league_butler/gateway/client/local_client.dart';
import 'package:league_butler/utils/logger.dart';

class RequestService extends GetxService {
  RequestService({required this.port});

  final String port;

  late final LocalClient _client = LocalClient.init(port: port);

  Future test() async {
    try {
      final response = await _client.get('/lol-summoner/v1/current-summoner/');

      logger.i(response);
    } on DioError catch (e) {
      logger.e(e.requestOptions.headers);
      logger.e(e);
    }
  }

  Future get(String path) async {
    return await _client.get(path);
  }
}
