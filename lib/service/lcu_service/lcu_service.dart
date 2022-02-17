import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/gateway/client/lcu_client.dart';
import 'package:league_butler/gateway/client/lcu_websocket_client.dart';
import 'package:league_butler/gateway/model/gateway_settings.dart';
import 'package:league_butler/models/lcu/queue/queue_model.dart';
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

  Future<Response> _get(String path) async => await _restClient.get(path[0] == '/' ? path : '/$path');
  Future<Response> _post(String path, [Map? body]) async => await _restClient.post(path[0] == '/' ? path : '/$path', data: body);

  List<String> currentEvents = [];

  Future<SummonerModel> getCurrentSummoner() async {
    final response = await _get('/lol-summoner/v1/current-summoner/');
    var data = response.data;
    data = data.toString().isNotEmpty ? data as Map<String, dynamic> : <String, dynamic>{'response': data};
    return SummonerModel.fromJson(data);
  }

  Future<dynamic> getSessionStatus() async {
    final response = await _get('/lol-login/v1/session/');
    final data = response.data;
    return data.toString().isNotEmpty ? data as Map<String, dynamic> : <String, dynamic>{'response': data};
  }

  Future<bool> acceptReadyCheck() async {
    try {
      final response = await _post('/lol-matchmaking/v1/ready-check/accept');
      logger.i(response.data);
      return response.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<List<QueueModel>> getQueues() async {
    final response = await _get('/lol-game-queues/v1/queues');
    return (response.data as List<dynamic>).map((e) => QueueModel.fromJson(e)).toList();
  }

  Future<void> test() async {
    logger.i((await _get('/lol-game-queues/v1/queues')).data);
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
    if (currentEvents.contains(event)) return false;

    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add('[5, "$event"]');
    currentEvents.add(event);
    return true;
  }

  bool addEvents(List<String> events) {
    if (events.any((event) => currentEvents.contains(event))) return false;

    final channel = _channel;
    if (channel == null) return false;
    for (final event in events) {
      channel.sink.add('[5, "$event"]');
    }
    currentEvents.addAll(events);
    return true;
  }

  bool removeEvent(String event) {
    if (!currentEvents.contains(event)) return false;

    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add('[6, "$event"]');
    currentEvents.remove(event);
    return true;
  }
}
