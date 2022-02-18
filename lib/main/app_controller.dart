import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/gateway_default_settings.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/models/lcu/lcu_websocket_response.dart';
import 'package:league_butler/models/lcu/queue/ready_check_model.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service_endpoints.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  String? port;
  String? token;

  LCUService? lcuService;
  final DataDragonService dataDragonService = Get.put(DataDragonService());

  late final queueController = Get.find<QueueController>();

  @override
  void onInit() {
    super.onInit();
    setUpRestClient();
  }

  Future<void> disconnect() async {
    Get.offAllNamed(Routes.waitingConnection.route);
    await Database().clearNonPersistent();
    await lcuService?.disconnectWebSocket();
    await Get.delete<LCUService>();
    lcuService = null;
    setUpRestClient();
  }

  Future<ProcessResult> findProcess() async =>
      await (Platform.isWindows ? Process.run('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']) : Process.run('ps', ['-A', '|', 'grep' 'LeagueClientUx']));

  Future<void> setUpRestClient() async {
    final leagueClientProcess = await findProcess();
    final token = _tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = _portRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    if (port == null || token == null) return Future.delayed(const Duration(seconds: 2)).then((_) => setUpRestClient());
    return finishSetUp(port, token);
  }

  Future<void> finishSetUp(String port, String token) async {
    lcuService = Get.put<LCUService>(LCUService(
      restClientSettings: await GatewayDefaultSettings.localClientSettings(port: port),
      webSocketClientSettings: await GatewayDefaultSettings.localClientWebSocketSettings(port: port),
    ));

    await Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));
    await setInitialInformation();
  }

  Future<void> setInitialInformation() async {
    final service = lcuService;
    if (service == null) return disconnect();
    while (true) {
      try {
        await service.getSessionStatus();
        break;
      } on DioError catch (e) {
        if (e.message.contains('SocketException') || e.response?.statusCode != 404) return disconnect();
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    final waitingController = Get.find<WaitingController>();
    waitingController.didConnect = true;

    return setUpWebSocket();
  }

  Future<void> setUpWebSocket() async {
    final service = lcuService;
    if (service == null) throw 'LCUService not set up';
    final lcuWebSocket = await service.getWebSocket();

    service.addEvents([wsQueueSearch, wsReadyCheck, wsLoginSession]);

    lcuWebSocket.stream.listen((event) async {
      final response = LCUWebSocketResponse.fromEvent(event);
      if (response == null) return;

      final queueStatus = queueController.isQueueEnabled;
      switch (response.event) {
        case wsLoginSession:
          if (!response.data.eventType.toLowerCase().contains('delete')) return;
          return await disconnect();

        case wsReadyCheck:
          if (queueStatus == false) return;

          final readyCheckResponse = ReadyCheckModel.fromJson(response.data.data);
          if (readyCheckResponse.timer < 2.0) return;

          for (var i = 0; i < 4; i++) {
            Future.delayed(const Duration(milliseconds: 250)).then((_) => service.acceptReadyCheck());
          }
          return;
      }
    });
  }
}
