import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/components/status_bar_item.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';
import 'package:league_butler/main/app_controller.dart';

class HorizontalStatusBar extends GetView<AppController> {
  const HorizontalStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Get.theme.colorScheme.tertiary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(controller.summoner.value?.displayName ?? '', style: Get.textTheme.headlineSmall?.copyWith(fontFamily: 'RobotoMono'),),
          const SizedBox(height: 64, width: 64),
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
    );
  }

}