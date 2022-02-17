import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/screens/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/gateway_default_settings.dart';
import 'package:league_butler/models/lcu/lcu_websocket_response.dart';
import 'package:league_butler/models/lcu/queue/ready_check_model.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service_endpoints.dart';
import 'package:league_butler/utils/logger.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  String? port;
  String? token;


  LCUService? lcuService;
  final DataDragonService dataDragonService = Get.put(DataDragonService());

  @override
  void onInit() {
    super.onInit();
    setUpRestClient();
  }

  void disconnect() {
    Database().clearNonPersistent();
    lcuService?.disconnectWebSocket();
    Get.delete<LCUService>().then((_) {
      lcuService = null;
      findProcess();
      Get.offAllNamed(Routes.waitingConnection.route);
    });
  }

  Future<ProcessResult> findProcess() async =>
      await (Platform.isWindows ? Process.run('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']) : Process.run('ps', ['-A', '|', 'grep' 'LeagueClientUx']));

  Future<void> finishSetUp(port, token) async {
    lcuService = Get.put<LCUService>(LCUService(
      restClientSettings: await GatewayDefaultSettings.localClientSettings(port: port),
      webSocketClientSettings: await GatewayDefaultSettings.localClientWebSocketSettings(port: port),
    ));

    Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));

    Get.find<WaitingController>().didConnect = true;
  }

  Future<void> setUpRestClient() async {
    final leagueClientProcess = await findProcess();
    final token = _tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = _portRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    if (port == null || token == null) return Future.delayed(const Duration(seconds: 2)).then((_) => setUpRestClient());
    return finishSetUp(port, token);
  }

  Future<void> setUpWebSocket() async {
    final service = lcuService;
    if (service == null) throw 'LCUService not set up';
    final lcuWebSocket = await service.getWebSocket();

    service.addEvents(const [wsQueueSearch, wsReadyCheck]);

    lcuWebSocket.stream.listen((event) async {
      final response = LCUWebSocketResponse.fromEvent(event);
      if (response == null) return;

      var isFalse2 = Get.find<StatusBarController>().queueStatus.isFalse;
      logger.d('readyCheck is off: $isFalse2');
      // logger.d('Received event ${response.event} with data: ${response.data}');
      switch (response.event) {
          /* TODO: Implement when queue logic is ready
        case wsQueueSearch:
          if (Get.find<StatusBarController>().queueStatus.isFalse) return;
          final queueSearch = QueueSearchModel.fromJson(response.data.data);
          break;  */
        case wsReadyCheck:
          if (isFalse2) return;

          logger.e('Received ready check');
          final readyCheckResponse = ReadyCheckModel.fromJson(response.data.data);
          if (readyCheckResponse.timer > 8) {
            logger.d('Ready check timer is greater than 8 seconds');
            service.acceptReadyCheck();
          }
          break;
      }
    });
  }

  Future<void> setInitialInformation() async {
    final service = lcuService;
    if (service == null) return disconnect();
    while (true) {
      try {
        final response = await service.getSessionStatus();
        logger.d('Session status: $response');
        lcuService?.test();

        return setUpWebSocket();
      } on DioError catch (e) {
        if (e.response?.statusCode != 404) return disconnect();
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
}
