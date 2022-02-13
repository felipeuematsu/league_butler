import 'package:get/get.dart';
import 'package:league_butler/screens/home/bindings/home_bindings.dart';
import 'package:league_butler/screens/home/view/home_view.dart';
import 'package:league_butler/screens/waiting/bindings/waiting_bindings.dart';
import 'package:league_butler/screens/waiting/view/waiting_view.dart';

class RoutesPages {
  RoutesPages._();

  static final pages = [
    GetPage(name: Routes.home.route, page: () => const HomeView(), binding: HomeBindings()),
    GetPage(name: Routes.waitingConnection.route, page: () => const WaitingView(), binding: WaitingBindings()),
  ];
}

enum Routes {
  home,
  waitingConnection
}

extension RoutesEnumExt on Routes {
  String get route => '/${name.replaceAll('_', '/')}';
}
