import 'package:get/get.dart';
import 'package:league_butler/main/main_bindings.dart';
import 'package:league_butler/main/view/main_view.dart';

class Routes {

  static final pages = [
    GetPage(name: RoutesEnum.home.route, page: () => const MainView(),
        binding: MainBindings()),
  ];
}

enum RoutesEnum {
  home,
}

extension RoutesEnumExt on RoutesEnum {
  String get route => '/${name.replaceAll('_', '/')}';
}