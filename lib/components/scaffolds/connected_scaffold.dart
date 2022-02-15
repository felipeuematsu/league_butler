import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/horizontal_status_bar/horizontal_status_bar.dart';
import 'package:league_butler/components/scaffolds/vertical_navigation_bar.dart';
import 'package:league_butler/components/scaffolds/window_scaffold.dart';
import 'package:league_butler/main/app_controller.dart';

class ConnectedScaffold extends GetView<AppController> {
  const ConnectedScaffold({Key? key, this.body}) : super(key: key);

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      body: Row(
        children: [
          const VerticalNavigationBar(),
          Expanded(
            child: Column(
              children: [
                const HorizontalStatusBar(),
                Expanded(child: body ?? Container()),
              ],
            )
          ),
        ],
      ),
    );
  }
}
