import 'package:get/get.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';

class WaitingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<WaitingController>(WaitingController());
  }
}