import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/window_scaffold.dart';
import 'package:league_butler/screens/coming_soon/coming_soon_strings.dart';
import 'package:league_butler/screens/waiting/waiting_strings.dart';
import 'package:league_butler/utils/screen_helper.dart';

class ComingSoonView extends GetView {
  const ComingSoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      background: Image.asset(controller.splashImage, opacity: const AlwaysStoppedAnimation(.6), fit: BoxFit.cover),
      body: Center(
        child: Column(
          children: [
            Text(
              WaitingStrings.waitingForClient.tr,
              textScaleFactor: ScreenHelper.scale,
              style: Get.textTheme.headlineSmall?.copyWith(
                color: Get.theme.colorScheme.surface,
              ),
            ),
            Text(ComingSoonStrings.description.tr),
          ],
        ),
      ),
    );
  }
}
