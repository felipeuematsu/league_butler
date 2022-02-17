import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/images_constants.dart';
import 'package:league_butler/commons/routes.dart';
import 'package:league_butler/commons/strings.dart';
import 'package:league_butler/main/app_controller.dart';
import 'package:league_butler/screens/waiting/waiting_strings.dart';

class WaitingController extends GetxController with GetSingleTickerProviderStateMixin {
  String getRandomSplashImage() => ImageConstants.splashImages.elementAt(Random().nextInt(ImageConstants.splashImages.length - 1));

  var didConnect = false;

  late final splashImage = getRandomSplashImage();

  late Animation<double> textAnimation;
  late AnimationController _animationController;

  final textContent = CommonStrings.leagueButler.tr.obs;

  Future<void> animate() async {
    await Future.delayed(const Duration(seconds: 2));
    _animationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    _animationController.reverse();
    await Future.delayed(const Duration(seconds: 1));
    textContent.value = WaitingStrings.waitingForClient.tr;
    _animationController.forward();

    return continuousAnimation();
  }

  Future<void> continuousAnimation() async {
    while (!didConnect) {
      await Future.delayed(const Duration(seconds: 2));
      if (didConnect) break;
      _animationController.reverse();
      await Future.delayed(const Duration(seconds: 1));
      if (didConnect) break;
      _animationController.forward();
    }
    return await goToHome();
  }

  Future<void> goToHome() async {
    textContent.value = WaitingStrings.clientFound.tr;
    _animationController.value = 1;
    await Future.delayed(const Duration(seconds: 3));
    await Get.find<AppController>().setInitialInformation();
    await Get.offAllNamed(Routes.home.route);
  }

  @override
  void onInit() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    textAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController)..addListener(() => update());
    super.onInit();
    animate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
