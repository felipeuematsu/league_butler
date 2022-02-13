import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/lb_images.dart';
import 'package:league_butler/main/view/components/waiting_main_view.dart';

class MainViewController extends GetxController {
  late final splashImage = getRandomSplashImage();

  final Rx<Widget> mainViewContent = const WaitingMainView().obs;

  String getRandomSplashImage() => LbImagesUtil.splashImages.elementAt(Random().nextInt(LbImagesUtil.splashImages.length - 1));

}
