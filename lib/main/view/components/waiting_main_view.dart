import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/components/window_scaffold.dart';
import 'package:league_butler/main/controller/main_view_controller.dart';
import 'package:league_butler/main/main_strings.dart';
import 'package:league_butler/utils/screen_helper.dart';

class WaitingMainView extends GetView<MainViewController> {
  const WaitingMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      background: Image.asset(controller.splashImage, opacity: const AlwaysStoppedAnimation(.6),fit: BoxFit.cover),
      body: Stack(
        children: [
          Positioned(
            left: Get.width * 0.05,
            bottom: Get.height * 0.05,
            child: Padding(
              padding: EdgeInsets.all(8.0.scale),
              child: Text(
                MainStrings.waitingForClient.tr,
                textScaleFactor: ScreenHelper.scale,
                style: Get.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
