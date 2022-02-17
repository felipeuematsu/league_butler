import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/horizontal_status_bar.dart';
import 'package:league_butler/components/scaffolds/vertical_navigation_bar.dart';
import 'package:league_butler/components/scaffolds/window_scaffold.dart';
import 'package:league_butler/main/app_controller.dart';
import 'package:league_butler/utils/screen_helper.dart';

class ConnectedScaffold extends GetView<AppController> {
  const ConnectedScaffold({Key? key, this.body}) : super(key: key);

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 64.scale,
            left: 64.scale,
            bottom: 0,
            right: 0,
            child: body ?? Container(),
          ),
          Positioned.fill(
            child: Material(
              elevation: 10,
              child: Stack(
                children: [
                  Positioned(
                    top: 64.scale,
                    left: 0,
                    width: 64.scale,
                    bottom: 0,
                    child: const VerticalNavigationBar(),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 64.scale,
                    child: const HorizontalStatusBar(),
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
