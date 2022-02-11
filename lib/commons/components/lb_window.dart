import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:league_butler/commons/components/window_buttons.dart';

class LbWindow extends StatelessWidget {

  const LbWindow({Key? key, required this.body, required this.background}) : super(key: key);

  final Widget body;
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
                      Expanded(child: MoveWindow()),
                      WindowButtons(),
                    ],
                  ),
                ),
                body,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
