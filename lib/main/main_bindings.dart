import 'package:get/get.dart';
import 'package:league_butler/main/controller/main_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}