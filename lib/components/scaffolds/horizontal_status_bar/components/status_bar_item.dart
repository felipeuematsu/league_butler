import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';

class StatusBarItem extends GetView<StatusBarController> {
  const StatusBarItem({Key? key, required this.type}) : super(key: key);

  final StatusBarItemType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTap(type),
      child: Obx(
        () => Container(
            margin: const EdgeInsets.all(4),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Material(
                elevation: 10,
                shape: const CircleBorder(),
                color: controller.isActivated(type).value ? Colors.green.shade400 : Colors.red.shade500,
                child: Container(
                  width: 60,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Icon(
                        controller.getIcon(type),
                        size: 24,
                        color: controller.isActivated(type).value ? Colors.white : Colors.black,
                      ),
                      Text(
                        type.name,
                        style: Get.textTheme.labelSmall?.copyWith(
                          color: controller.isActivated(type).value ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
