import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowButtons extends StatelessWidget {
  final _buttonColors = WindowButtonColors(
    normal: Colors.white.withOpacity(.2),
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500),
  );

  final _closeButtonColors = WindowButtonColors(
    normal: Colors.white.withOpacity(.2),
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: _buttonColors),
        CloseWindowButton(colors: _closeButtonColors),
      ],
    );
  }
}
