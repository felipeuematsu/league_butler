import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:league_butler/commons/components/window_buttons.dart';

class WindowScaffold extends StatelessWidget {

  const WindowScaffold({Key? key, this.body, required this.background}) : super(key: key);

  final Widget? body;
  final Widget background;

  @override
  Widget build(BuildContext context) {

    return WindowBorder(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(child: background),
          Positioned.fill(
            child: Column(
              children: [
                WindowTitleBarBox(
                  child: Row(
                    children: [
                      const Expanded(child: _CustomMoveWindow()),
                      WindowButtons(),
                    ],
                  ),
                ),
                Expanded(child: body ?? Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomMoveWindow extends StatelessWidget {
  const _CustomMoveWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) => appWindow.startDragging(),
    );

  }
}