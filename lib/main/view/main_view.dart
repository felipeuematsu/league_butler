import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/components/lb_window.dart';
import 'package:league_butler/main/controller/main_view_controller.dart';
import 'package:league_butler/main/main_strings.dart';

class MainView extends GetView<MainViewController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LbWindow(
      background: Image.asset(controller.splashImage, fit: BoxFit.cover),
      body: Center(
        child: Text(
          MainStrings.waitingForClient.tr,
          style: const TextStyle(color: Colors.white, fontSize: 64),
        ),
      ),
    );
  }
}
