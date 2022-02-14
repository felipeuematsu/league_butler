import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/screens/home/controller/home_view_controller.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/service/lcu_service.dart';
import 'package:league_butler/utils/logger.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  final connected = false.obs;

  String? port;
  String? token;

  bool get isConnected => connected.value;

  LCUService? lcuService;

  Future<void> disconnect() async {
    connected.value = false;
    await Database().clearNonPersistent();
    await Get.delete<LCUService>();
    await Get.delete<HomeViewController>();
  }

  Future<void> healthCheck() async {
    lcuService?.ping();
    await Future.delayed(const Duration(seconds: 5));
    healthCheck();
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

    Get.lazyPut<LCUService>(() => lcuService = LCUService(port: port));

    await Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));
    healthCheck();
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
}
