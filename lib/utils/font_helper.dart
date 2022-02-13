import 'package:flutter/widgets.dart';
import 'package:league_butler/utils/screen_helper.dart';

class FontHelper {
  static TextStyle? adapt(TextStyle? style) => style?.apply(fontSizeFactor: ScreenHelper.getScreenSize._scale);
}
