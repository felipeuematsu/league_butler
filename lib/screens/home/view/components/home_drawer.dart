import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/utils/screen_helper.dart';

class HomeDrawer extends GetView {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.secondary,
      width: ScreenSize.s1600x900.size.width * .2,
      child: ListView(
        children: const [],
      ),
    );
  }
}
