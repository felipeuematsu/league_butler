import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:league_butler/commons/lb_images.dart';
import 'package:league_butler/main/controller/app_controller.dart';

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

    final tokenRegex = RegExp('remoting-auth-token=([\\w-]*)');
    final portRegex = RegExp('app-port=(\\d*)');

    final token = tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = int.tryParse(portRegex.firstMatch(leagueClientProcess.stdout)?.group(1) ?? '');

    if (port == null || token == null) return await Future.delayed(const Duration(seconds: 2)).then((_) async => await findProcess());

    print('Found LeagueClientUx.exe with token $token and port $port');

    Get.lazyPut<AppController>(() => AppController(port: port, token: token));
  }

  @override
  void onInit() {
    super.onInit();
    findProcess();
  }
}
