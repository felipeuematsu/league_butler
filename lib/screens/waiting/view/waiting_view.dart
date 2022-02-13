import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/components/window_scaffold.dart';
import 'package:league_butler/screens/waiting/controller/waiting_controller.dart';
import 'package:league_butler/utils/screen_helper.dart';

class WaitingView extends GetView<WaitingController> {
  const WaitingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      background: Image.asset(controller.splashImage, opacity: const AlwaysStoppedAnimation(.6), fit: BoxFit.cover),
      body: Expanded(
        child: Stack(
          children: [
            Positioned(
              left: Get.width * 0.05,
              bottom: Get.height * 0.05,
              child: Obx(() => FadeTransition(
                    opacity: controller.textAnimation,
                    child: controller.textContent.isNotEmpty ? Text(
                      controller.textContent.value,
                      textScaleFactor: ScreenHelper.scale,
                      style: Get.textTheme.headlineSmall?.copyWith(
                        color: Get.theme.colorScheme.surface,
                      ),
                    ): Container() ,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
