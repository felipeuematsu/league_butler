import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/screens/queue/view/components/queue_view_header.dart';

class QueueView extends GetView<QueueController> {
  const QueueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: appWindow.size.width - 64,
      height: appWindow.size.height - 64,
      child: Wrap(
        children: [
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(24),
            child: SizedBox(
              width: QueueViewHeader.minWidth,
              child: ListView(

                shrinkWrap: true,
                children: const [QueueViewHeader()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
