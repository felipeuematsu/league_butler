import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/gateway/client/lcu_client.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';
import 'package:league_butler/models/main/summoner_model.dart';

class LCUService extends GetxService {
  LCUService({required this.port, required GatewaySettings gatewaySettings}) : _settings = gatewaySettings;

  final String port;

  final GatewaySettings _settings;

  late final LCUClient _client = LCUClient.init(port: port, settings: _settings);

  Future<Response> _get(String path) async => await _client.get(path);

  Future<SummonerModel> getCurrentSummoner() async {
    final response = await _get('/lol-summoner/v1/current-summoner/');
    // logger.d(response.data);
    final data = response.data;
    response.data = data.toString().isNotEmpty  ? data as Map<String, dynamic> : <String, dynamic>{'response': data};
    return SummonerModel.fromJson(response.data);
  }

  test() async {
    // final response = await _get('/system/v1/builds');
    // logger.i(await getVersion());
  }

}
