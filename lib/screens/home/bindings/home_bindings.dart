import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';
import 'package:league_butler/screens/home/controller/home_view_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewController());
    Get.put(StatusBarController());
  }
}