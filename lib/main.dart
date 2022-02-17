import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:league_butler/commons/config_override.dart';
import 'package:league_butler/commons/lib_color_schemes.g.dart';
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/gateway/client/data_dragon_client.dart';
import 'package:league_butler/main/app_controller.dart';
import 'package:league_butler/main/features/ban_controller.dart';
import 'package:league_butler/main/features/pick_controller.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/utils/screen_helper.dart';

import 'commons/strings.dart';

Future<void> initDependencies() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();
  DataDragonClient.init();
}

Future<void> main() async {
  await initDependencies();
  final database = Database();
  runApp(LeagueButler(locale: await database.read<Locale>(DatabaseKeys.locale, persistent: true)));

  doWhenWindowReady(() async {
    final size = await database.read<ScreenSize>(DatabaseKeys.windowSize) ?? ScreenSize.s1024x576;
    appWindow.minSize = ScreenSize.s1024x576.size;
    appWindow.size = size.size;
    appWindow.alignment = Alignment.center;
    appWindow.title = CommonStrings.leagueButler.tr;
    appWindow.show();
  });
}

class LeagueButler extends StatelessWidget {
  const LeagueButler({Key? key, this.locale}) : super(key: key);

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());
    Get.put(QueueController());
    Get.put(BanController());
    Get.put(PickController());

    return GetMaterialApp(
      translations: Strings(),
      title: CommonStrings.leagueButler.tr,
      locale: locale ?? Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: RoutesPages.pages,
      initialRoute: Routes.waitingConnection.route,
      theme: ThemeData.from(colorScheme: lightColorScheme, textTheme: GoogleFonts.robotoTextTheme().apply(fontFamily: 'RobotoSerif')),
      darkTheme: ThemeData.from(colorScheme: darkColorScheme, textTheme: GoogleFonts.robotoTextTheme().apply(fontFamily: 'RobotoSerif')),
    );
  }
}
