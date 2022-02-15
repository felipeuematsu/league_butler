import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/components/scaffolds/connected_scaffold.dart';
import 'package:league_butler/screens/home/controller/home_view_controller.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ConnectedScaffold(
      // body: Text('Connected!'),
    );
  }
}
