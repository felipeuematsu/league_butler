import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/components/status_bar_item.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';

class HorizontalStatusBar extends GetView<StatusBarController> {
  const HorizontalStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      elevation: 4,
      child: Container(
        height: 64,
        color: Get.theme.colorScheme.surface.withOpacity(.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Obx(() => CircleAvatar(
                            radius: 30,
                            foregroundImage: NetworkImage(controller.dataDragonService.getProfileIconUrl(controller.summoner.value?.profileIconId ?? 1)),
                          )),
                    ),
                  ),
                  Obx(() => Text(controller.summoner.value?.displayName ?? '', style: Get.textTheme.headlineSmall?.copyWith(fontFamily: 'RobotoMono', color: Get.theme.colorScheme.onSurface))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                StatusBarItem(type: StatusBarItemType.queue),
                StatusBarItem(type: StatusBarItemType.ban),
                StatusBarItem(type: StatusBarItemType.pick),
              ],
            )
          ],
        ),
      ),
    );
  }
}
