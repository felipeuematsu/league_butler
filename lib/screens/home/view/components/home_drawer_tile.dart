
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/screens/home/controller/home_view_controller.dart';

class HomeDrawerTile extends GetView<HomeViewController> {
  const HomeDrawerTile({Key? key, this.icon}) : super(key: key);

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: const Text('Home'),
      onTap: () => Get.toNamed('/home'),
    );
  }
}