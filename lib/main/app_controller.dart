import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/gateway_default_settings.dart';
import 'package:league_butler/models/lcu/summoner_model.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service_endpoints.dart';
import 'package:league_butler/utils/logger.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  final connected = false.obs;
  bool get isConnected => connected.value;

  String? port;
  String? token;

  Rx<SummonerModel?> summoner = Rx<SummonerModel?>(null);

  LCUService? lcuService;
  final DataDragonService dataDragonService = Get.put(DataDragonService());

  void disconnect() {
    connected.value = false;
    Database().clearNonPersistent();
    lcuService?.disconnectWebSocket();
    Get.delete<LCUService>().then((_) {
      lcuService = null;
      findProcess();
      Get.offAllNamed(Routes.waitingConnection.route);
    });
  }

  Future<ProcessResult> findProcess() async {
    if (Platform.isWindows) {
      return await Process.run('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']);
    } else {
      return await Process.run('ps', ['-A', '|', 'grep' 'LeagueClientUx']);
    }
  }

  Future<void> finishSetUp(port, token) async {
    logger.d('Found LeagueClientUx.exe with token $token and port $port');
    connected.value = true;

    lcuService = Get.put<LCUService>(LCUService(
      restClientSettings: await GatewayDefaultSettings.localClientSettings(port: port),
      webSocketClientSettings: await GatewayDefaultSettings.localClientWebSocketSettings(port: port),
    ));

    Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));

    Get.find<WaitingController>().didConnect = true;
  }

  Future<void> setUpClient() async {
    final leagueClientProcess = await findProcess();

    final token = _tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = _portRegex.firstMatch(leagueClientProcess.stdout)?.group(1);

    if (port == null || token == null) return Future.delayed(const Duration(seconds: 2)).then((_) => setUpClient());
    return finishSetUp(port, token);
  }

  @override
  void onInit() {
    super.onInit();
    setUpClient();
  }

  Future<void> setUpWebSocket() async {
    final service = lcuService;
    if (service == null) throw 'LCUService not set up';
    final lcuWebSocket = await service.getWebSocket();

    service.addEvents(const [wsQueueSearch, wsReadyCheck]);

    lcuWebSocket.stream.listen((event) {
      if (event is String && event.isNotEmpty) {
        final List<dynamic> list = json.decode(event.toString());
        final String eventName = list.elementAt(1);
        final Map<String, dynamic> eventData = list.elementAt(2);
        logger.d('Received event $eventName with data: $eventData');
        switch (eventName) {
          case wsQueueSearch:
            summoner.value = SummonerModel.fromJson(eventData);
            break;
          case wsReadyCheck:
            summoner.value = null;
            break;
        }
      }
    });
  }

  Future<void> setInitialInformation() async {
    final service = lcuService;
    if (service == null) return disconnect();

    while (summoner.value == null) {
      try {
        final response = await service.getCurrentSummoner();
        summoner.value = response;
        setUpWebSocket();
      } on DioError catch (e) {
        if (e.response?.statusCode != 404) return disconnect();
          await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
}
