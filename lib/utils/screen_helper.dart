import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';

class ScreenHelper {
  ScreenHelper._();

  static var isShowingDialog = false;

  static double get scale => getScreenSize.scale;

  static ScreenSize get getScreenSize {
    switch (appWindow.size.width.toInt()) {
      case 1280:
        return ScreenSize.s1280x720;
      case 1600:
        return ScreenSize.s1600x900;
      default:
        return ScreenSize.s1024x576;
    }
  }

  static void updateScreenSize(ScreenSize screenSize) {
    Database().write(DatabaseKeys.windowSize, screenSize);
    appWindow.minSize = screenSize.size;
    appWindow.maxSize = screenSize.size;
  }
}

enum ScreenSize {
  s1024x576,
  s1280x720,
  s1600x900,
}

extension ScreenSizeExt on ScreenSize {
  Size get size {
    switch (this) {
      case ScreenSize.s1024x576:
        return const Size(1024, 576);
      case ScreenSize.s1280x720:
        return const Size(1280, 720);
      case ScreenSize.s1600x900:
        return const Size(1600, 900);
    }
  }

  double get scale {
    switch (this) {
      case ScreenSize.s1024x576:
        return 1.0;
      case ScreenSize.s1280x720:
        return 1280 / 768;
      case ScreenSize.s1600x900:
        return 1600 / 768;
    }
  }
}

extension NumExt on num {
  double get scale {
    return this * ScreenHelper.getScreenSize.scale;
  }
}

double scale(num value) => value * ScreenHelper.getScreenSize.scale;
