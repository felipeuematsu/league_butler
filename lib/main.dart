import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/utils/screen_helper.dart';

import 'commons/strings.dart';

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();
}

Future<void> main() async {
  await initDependencies();
  runApp(const LeagueButler());

  doWhenWindowReady(() async {
    final size = await Database().read<ScreenSize>(DatabaseKeys.windowSize) ?? ScreenSize.s1024x576;
    appWindow.minSize = size.size;
    appWindow.maxSize = size.size;
    appWindow.size = size.size;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class LeagueButler extends StatelessWidget {
  const LeagueButler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Strings(),
      title: CommonStrings.leagueButler.tr,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      getPages: Routes.pages,
      initialRoute: RoutesEnum.home.route,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
