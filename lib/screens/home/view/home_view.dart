import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/components/window_scaffold.dart';
import 'package:league_butler/screens/home/controller/home_view_controller.dart';
import 'package:league_butler/screens/home/view/components/home_drawer.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowScaffold(
      body: Expanded(
        child: Row(
          children: [
            const HomeDrawer(),
            Expanded(
              child: Column(
                children: const [
                  Expanded(
                    child: Text('Connected!'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
