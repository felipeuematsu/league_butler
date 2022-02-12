import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/components/window_scaffold.dart';
import 'package:league_butler/main/controller/main_view_controller.dart';
import 'package:league_butler/main/main_strings.dart';

class MainView extends GetView<MainViewController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      background: Image.asset(controller.splashImage, fit: BoxFit.cover),
      body: Stack(children: [
        Positioned(
          left: Get.width * 0.1,
          bottom: Get.height * 0.1,
          child: Center(
            child: Text(
              MainStrings.waitingForClient.tr,
              style: const TextStyle(color: Colors.white, fontSize: 64),
            ),
          ),
        ),
      ]),
    );
  }
}
