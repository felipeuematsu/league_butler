import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/app_controller.dart';

class VerticalNavigationBar extends GetView<AppController> {
  const VerticalNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 30,
                foregroundImage: NetworkImage(controller.dataDragonService.getProfileIconUrl(controller.summoner.value?.profileIconId ?? 1)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
