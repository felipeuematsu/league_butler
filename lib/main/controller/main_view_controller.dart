import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/services.dart';
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

    var dio = Dio();
    dio.options.headers['authorization'] = 'Basic $encoded';
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['content-type'] = 'application/json';
    dio.options.baseUrl = 'https://127.0.0.1:$port';
    dio.httpClientAdapter = Http2Adapter(ConnectionManager(
      onClientCreate: (uri, p1) async {
        p1.onBadCertificate = (certificate) => true;
        final sc = SecurityContext(withTrustedRoots: true);
        var certificatePemByteData = await rootBundle.load('assets/certificate/riotgames.pem');
        var certificatePemData = certificatePemByteData.buffer.asUint8List(certificatePemByteData.offsetInBytes, certificatePemByteData.lengthInBytes);

        sc.useCertificateChainBytes(certificatePemData);
        p1.context = sc;
      },
    ));
    var response = await dio.get('/lol-summoner/v1/current-summoner/');
    logger.d('Response: ${response.data}');

    await requestService.test();
  }

  @override
  void onInit() {
    super.onInit();
    findProcess();
  }
}
