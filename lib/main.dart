import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final database = Database();
  runApp(LeagueButler(locale: await database.read<Locale>(DatabaseKeys.locale, persistent: true),));

  doWhenWindowReady(() async {
    final size = await database.read<ScreenSize>(DatabaseKeys.windowSize) ?? ScreenSize.s1600x900;
    appWindow.minSize = size.size;
    appWindow.maxSize = size.size;
    appWindow.size = size.size;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class LeagueButler extends StatelessWidget {
  const LeagueButler({Key? key, this.locale}) : super(key: key);

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Strings(),
      title: CommonStrings.leagueButler.tr,
      locale: locale ?? Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: Routes.pages,
      initialRoute: RoutesEnum.home.route,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
