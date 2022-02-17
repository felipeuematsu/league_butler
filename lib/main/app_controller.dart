import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
import 'package:league_butler/utils/logger.dart';
import 'package:league_butler/utils/screen_helper.dart';

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

  Future<void> disconnect() async {
    Get.offAllNamed(Routes.waitingConnection.route);
    await reconnect();
  }

  Future<void> reconnect() async {
    await Database().clearNonPersistent();
    await lcuService?.disconnectWebSocket();
    await Get.delete<LCUService>();
    lcuService = null;
    setUpRestClient();
  }

  Future<ProcessResult> findProcess() async =>
      await (Platform.isWindows ? Process.run('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']) : Process.run('ps', ['-A', '|', 'grep' 'LeagueClientUx']));

  Future<void> finishSetUp(String port, String token) async {
    lcuService = Get.put<LCUService>(LCUService(
      restClientSettings: await GatewayDefaultSettings.localClientSettings(port: port),
      webSocketClientSettings: await GatewayDefaultSettings.localClientWebSocketSettings(port: port),
    ));

    await Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));
    logger.i('Token: ${base64.encode('riot:$token'.codeUnits)}');
    await setInitialInformation();
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

    service.addEvents(const [wsQueueSearch, wsReadyCheck, wsLoginSession]);

    lcuWebSocket.stream.listen((event) async {
      final response = LCUWebSocketResponse.fromEvent(event);
      if (response == null) return;

      var queueStatusIsFalse = Get.find<QueueController>().queueConfiguration.value.isActivated;
      logger.d('readyCheck is : ${!queueStatusIsFalse}');
      // logger.d('Received event ${response.event} with data: ${response.data}');
      switch (response.event) {
        case wsLoginSession:
          logger.i(response.data.eventType + '\n' + response.data.toString());
          if (response.data.eventType.toLowerCase().contains('delete')) {
            logger.e('Disconnecting because of session call ');
            if (await service.disconnectWebSocket()) {
              await disconnect();
            }
          }
          return;

        /* TODO: Implement when queue logic is ready
        case wsQueueSearch:
          if (Get.find<StatusBarController>().queueStatus.isFalse) return;
          final queueSearch = QueueSearchModel.fromJson(response.data.data);
          break;  */
        case wsReadyCheck:
          if (queueStatusIsFalse) return;

          logger.i('Received ready check');
          final readyCheckResponse = ReadyCheckModel.fromJson(response.data.data);
          if (readyCheckResponse.timer > 2.0) {
            logger.d('Ready check timer is greater than 2 seconds');
            for (var i = 0; i < 4; i++) {
              Future.delayed(const Duration(milliseconds: 200)).then((value) async {
                if (ScreenHelper.isShowingDialog) Get.back();
                if (!await service.acceptReadyCheck()) {
                  Get.defaultDialog(
                    title: 'Error',
                    content: const Text('Failed to accept ready check'),
                    barrierDismissible: false,
                    onConfirm: () {
                      ScreenHelper.isShowingDialog = false;
                      Get.back();
                    },
                  );
                } else {
                  Get.defaultDialog(
                    title: 'Accepted',
                    content: const Text('Accepted ready check'),
                    barrierDismissible: false,
                    onConfirm: () {
                      ScreenHelper.isShowingDialog = false;
                      Get.back();
                    },
                  );
                }
                ScreenHelper.isShowingDialog = true;
              });
            }
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
        await service.getSessionStatus();
        Get.find<WaitingController>().didConnect = true;

        return setUpWebSocket();
      } on DioError catch (e) {
        if (e.message.contains('SocketException') || e.response?.statusCode != 404) return disconnect();
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
}
