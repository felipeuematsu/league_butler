import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:league_butler/commons/lb_images.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/service/request_service.dart';
import 'package:league_butler/utils/logger.dart';

class MainViewController extends GetxController {
  late final splashImage = getRandomSplashImage();

  String getRandomSplashImage() => LbImagesUtil.splashImages.elementAt(Random().nextInt(LbImagesUtil.splashImages.length - 1));

  Future<void> findProcess() async {
    late final ProcessResult leagueClientProcess;

    if (Platform.isWindows) {
      leagueClientProcess = Process.runSync('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']);
    } else {
      leagueClientProcess = Process.runSync('ps', ['-A', '|', 'grep' 'LeagueClientUx']);
    }

    final tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
    final portRegex = RegExp('--app-port=(\\d*)');

    final token = tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = portRegex.firstMatch(leagueClientProcess.stdout)?.group(1);

    if (port == null || token == null) {
      return await Future.delayed(const Duration(seconds: 2)).then((_) async {
        logger.d('LeagueClientUx not found, retrying...');
        await findProcess();
    });
    }

    logger.d('Found LeagueClientUx.exe with token $token and port $port');
    final requestService = RequestService(port: port);

    Get.lazyPut<RequestService>(() => requestService);

    var encoded = base64.encode('riot:$token'.codeUnits);
    logger.i('Encoded $encoded');
    await Database().write(DatabaseKeys.localTokenBase64, encoded);

    await requestService.test();
  }

  @override
  void onInit() {
    super.onInit();
    findProcess();
  }
}
