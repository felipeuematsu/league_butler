import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/service/request_service.dart';
import 'package:league_butler/utils/logger.dart';
import 'package:league_butler/utils/screen_helper.dart';

final _tokenRegex = RegExp('--remoting-auth-token=([\\w-]*)');
final _portRegex = RegExp('--app-port=(\\d*)');

class AppController extends GetxController {
  ProcessResult findProcess() {
    if (Platform.isWindows) {
      return Process.runSync('wmic', ['PROCESS', 'WHERE', "name='LeagueClientUx.exe'", 'GET', 'commandline']);
    } else {
      return Process.runSync('ps', ['-A', '|', 'grep' 'LeagueClientUx']);
    }
  }

  Future<void> setUpClient() async {
    final leagueClientProcess = findProcess();

    final token = _tokenRegex.firstMatch(leagueClientProcess.stdout)?.group(1);
    final port = _portRegex.firstMatch(leagueClientProcess.stdout)?.group(1);

    if (port == null || token == null) return await Future.delayed(const Duration(seconds: 2)).then((_) async => await setUpClient());

    logger.d('Found LeagueClientUx.exe with token $token and port $port');

    Get.lazyPut<RequestService>(() => RequestService(port: port));

    final encoded = base64.encode('riot:$token'.codeUnits);
    await Database().write(DatabaseKeys.localTokenBase64, encoded);

    await RequestService(port: port).test();
  }

  @override
  void onInit() {
    super.onInit();
    setUpClient();
  }

  @override
  void onReady() {
    super.onReady();
    Get.defaultDialog(
      backgroundColor: Colors.grey.shade900,
      barrierDismissible: false,
      actions: [
        FlatButton(
          child: Text('Close', textScaleFactor: ScreenHelper.scale, style: Get.textTheme.button?.copyWith(color: Colors.white)),
          onPressed: () => Get.back(),
        ),
      ],
      title: 'Configs',
      titleStyle: Get.textTheme.headlineSmall?.copyWith(color: Colors.white),
      content: Padding(padding: EdgeInsets.all(24.0.scale),child: Text('Found LeagueClientUx.exe', textScaleFactor: ScreenHelper.scale, style: Get.textTheme.bodyMedium?.copyWith(color: Colors.white))),
    );
  }
}
