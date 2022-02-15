import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/window_buttons.dart';
import 'package:league_butler/utils/screen_helper.dart';

class WindowScaffold extends StatelessWidget {
  const WindowScaffold({Key? key, this.body, this.background}) : super(key: key);

  final Widget? body;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(child: background ?? Container(color: Get.theme.colorScheme.background,)),
          Positioned.fill(
            child: Column(
              children: [
                WindowTitleBarBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.scale, top: 2.scale),
            child: Icon(
              Icons.ac_unit,
              color: Get.theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
