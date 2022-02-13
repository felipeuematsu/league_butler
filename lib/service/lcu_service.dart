import 'package:get/get.dart';
import 'package:league_butler/gateway/client/local_client.dart';
import 'package:league_butler/utils/logger.dart';

class LCUService extends GetxService {
  LCUService({required this.port});

  final String port;

  late final LocalClient _client = LocalClient.init(port: port);

  Future<void> ping() async {
    await _client.get('/lol-summoner/v1/current-summoner/');
    logger.v('LCU Service is up');
  }

  Future get(String path) async {
    return await _client.get(path);
  }
}
