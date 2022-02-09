import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/routes.dart';

import 'commons/strings.dart';

void main() {
  runApp(const LeagueButler());
}

class LeagueButler extends StatelessWidget {
  const LeagueButler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Strings(),
      title: StringsEnum.leagueButler.tr,
      fallbackLocale: const Locale('en', 'US'),
      getPages: Routes.pages,
      initialRoute: RoutesEnum.home.route,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
