import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';

class ScreenHelper {
  ScreenSize getScreenSize() {
    switch (appWindow.size.width.toInt()) {
      case 1280:
        return ScreenSize.s1280x720;
      case 1600:
        return ScreenSize.s1600x900;
      default:
        return ScreenSize.s1024x576;
    }
  }

  void updateScreenSize(ScreenSize screenSize) {
    appWindow.minSize = screenSize.size;
    appWindow.maxSize = screenSize.size;
    Database().write(DatabaseKeys.windowSize, screenSize);
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
}
