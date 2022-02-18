import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/screens/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';

class StatusBarItem extends GetView<StatusBarController> {
  const StatusBarItem({Key? key, required this.type}) : super(key: key);

  final StatusBarItemType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Obx(() => MaterialButton(
            elevation: 2,
            color: controller.isActivated(type) ? Colors.greenAccent.withOpacity(0.6) : Get.theme.colorScheme.surfaceVariant.withOpacity(0.5),
            onPressed: () => controller.onTap(type),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    controller.getIcon(type),
                    size: 24,
                    color: controller.isActivated(type) ? Colors.white : Colors.black,
                  ),
                  Text(
                    controller.getButtonText(type),
                    style: Get.textTheme.labelSmall?.copyWith(
                      color: controller.isActivated(type) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
