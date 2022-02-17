import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/controller/status_bar_controller.dart';

class VerticalNavigationBar extends GetView<StatusBarController> {
  const VerticalNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        color: Get.theme.colorScheme.surface,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
