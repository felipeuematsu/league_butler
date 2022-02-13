import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/controller/main_view_controller.dart';

class MainView extends GetView<MainViewController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.mainViewContent.value);
  }
}
