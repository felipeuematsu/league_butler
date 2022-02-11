import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:league_butler/commons/lb_images.dart';
import 'package:league_butler/main/controller/app_controller.dart';

class MainViewController extends GetxController {
  late final splashImage = getRandomSplashImage();
  static const username = 'riot';

  String getRandomSplashImage() => LbImagesUtil.splashImages.elementAt(Random().nextInt(LbImagesUtil.splashImages.length - 1));

  Future<void> findProcess() async {
    late final ProcessResult leagueClientProcess;

    if (Platform.isWindows) {
      leagueClientProcess = Process.runSync('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']);
    } else {
      leagueClientProcess = Process.runSync('ps', ['-A', '|', 'grep' 'LeagueClientUx']);
    }

    print(leagueClientProcess.stdout);

    final processRegex = RegExp('(.*):(\\d*):(\\d*):(.*):(.*)');
    final matches = processRegex.firstMatch(leagueClientProcess.stdout);

    final port = int.tryParse(matches?.group(4) ?? '');
    final password = matches?.group(5);

    if (port == null || password == null) {
      return await Future.delayed(const Duration(seconds: 2)).then((value) async => await findProcess());
    }

    final encoded = base64.encode('$username:$password'.codeUnits);

    Get.lazyPut<AppController>(() => AppController(port: port, password: encoded));
  }
}
