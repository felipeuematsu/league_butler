import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:league_butler/gateway/client/local_client.dart';

class RequestService extends GetxService {
  RequestService({required this.token, required this.port});

  final host = 'https://127.0.0.1';
  final String token;
  final int port;

  late final _client = LocalClient();

  Future test() async {
    try {
      final response = await _client.get('/lol-summoner/v1/current-summoner');

      print(response.data);
    } on DioError catch (e) {
      print('host ' + _client.options.baseUrl);
      print(e);
    }
  }

  Future get(String path) async {
    return await _client.get(path);
  }
}
