import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/gateway/client/lcu_client.dart';
import 'package:league_butler/gateway/client/lcu_websocket_client.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';
import 'package:league_butler/models/lcu/summoner_model.dart';
import 'package:league_butler/utils/logger.dart';
import 'package:web_socket_channel/io.dart';

class LCUService extends GetxService {
  LCUService({required GatewaySettings restClientSettings, required GatewaySettings webSocketClientSettings})
      : _settings = restClientSettings,
        _webSocketSettings = webSocketClientSettings;

  final GatewaySettings _settings, _webSocketSettings;

  late final LCUClient _restClient = LCUClient.init(settings: _settings);

  late final LCUWebSocketClient _websocketClient = LCUWebSocketClient(settings: _webSocketSettings);

  IOWebSocketChannel? _channel;

  Future<Response> _get(String path) async => await _restClient.get(path);

  Future<SummonerModel> getCurrentSummoner() async {
    final response = await _get('/lol-summoner/v1/current-summoner/');
    var data = response.data;
    data = data.toString().isNotEmpty ? data as Map<String, dynamic> : <String, dynamic>{'response': data};
    return SummonerModel.fromJson(data);
  }

  void help() async {
    logger.i(await _get('/Help'));
  }

  Future<IOWebSocketChannel> getWebSocket() async {
    final channel = _channel;
    if (channel != null) return channel;
    final connection = await _websocketClient.connect();
    return _channel = connection;
  }

  Future<void> disconnectWebSocket() async {
    final channel = _channel;
    if (channel == null) return;
    await channel.sink.close();
    _channel = null;
  }

  bool addEvent(String event) {
    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add('[5, "$event"]');
    return true;
  }

  bool addEvents(List<String> events) {
    final channel = _channel;
    if (channel == null) return false;
    for (final event in events) {
      channel.sink.add('[5, "$event"]');
    }
    return true;
  }

  bool removeEvent(String event) {
    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add('[6, "$event"]');
    return true;
  }
}
