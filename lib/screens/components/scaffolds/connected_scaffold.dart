import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/app_controller.dart';
import 'package:league_butler/screens/components/scaffolds/horizontal_status_bar/horizontal_status_bar.dart';
import 'package:league_butler/screens/components/scaffolds/vertical_navigation_bar.dart';
import 'package:league_butler/screens/components/scaffolds/window_scaffold.dart';

class ConnectedScaffold extends GetView<AppController> {
  const ConnectedScaffold({Key? key, this.body}) : super(key: key);

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 64,
            left: 64,
            child: body ?? Container(),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: const [
                  Positioned(
                    top: 64,
                    left: 0,
                    width: 64,
                    bottom: 0,
                    child: VerticalNavigationBar(),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 64,
                    child: HorizontalStatusBar(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
