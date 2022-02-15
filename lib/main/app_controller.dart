import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart' hide Response;
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/gateway_default_settings.dart';
import 'package:league_butler/models/main/summoner_model.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service.dart';
import 'package:league_butler/utils/logger.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  final connected = false.obs;

  String? port;
  String? token;

  Rx<SummonerModel?> summoner = Rx<SummonerModel?>(null);

  bool get isConnected => connected.value;

  LCUService? lcuService;
  final DataDragonService dataDragonService = DataDragonService();
  void disconnect() {
    connected.value = false;
    Database().clearNonPersistent();
    Get.delete<LCUService>().then((_) {
      lcuService = null;
      findProcess();
    });
  }

  // TODO: Use WebSockets instead of HTTP
  void healthCheck() {
    // lcuService?.ping();
    // Future.delayed(const Duration(seconds: 5)).then((_) => healthCheck());
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

    lcuService = Get.put<LCUService>(LCUService(port: port, gatewaySettings: await GatewayDefaultSettings.localClientSettings(port: port)));

    Database().write(DatabaseKeys.localTokenBase64, base64.encode('riot:$token'.codeUnits));

    setInitialInformation();
    // healthCheck();
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

  Future<void> setInitialInformation() async {
    final service = lcuService;
    if (service == null) return disconnect();

    service.test();


    summoner.value = await service.getCurrentSummoner();
  }
}
