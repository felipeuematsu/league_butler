import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/features/feature_type.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/models/lcu/queues.dart';
import 'package:league_butler/screens/queue/view/components/queue_header_button_switch.dart';
import 'package:league_butler/screens/queue/view/components/queue_header_cell.dart';
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 3,
            margin: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(6),
              width: QueueViewHeader.minWidth,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const QueueViewHeader(),
                  const Divider(),
                  Row(
                    children: [
                      QueueHeaderCell(text: QueueType.casual.name),
                      const QueueHeaderButtonSwitch(queueType: QueueType.casual, featureType: FeatureType.queue),
                      const QueueHeaderButtonSwitch(queueType: QueueType.casual, featureType: FeatureType.ban),
                      const QueueHeaderButtonSwitch(queueType: QueueType.casual, featureType: FeatureType.pick),
                    ],
                  ),
                  Row(
                    children: [
                      QueueHeaderCell(text: QueueType.ranked.name),
                      const QueueHeaderButtonSwitch(queueType: QueueType.ranked, featureType: FeatureType.queue),
                      const QueueHeaderButtonSwitch(queueType: QueueType.ranked, featureType: FeatureType.ban),
                      const QueueHeaderButtonSwitch(queueType: QueueType.ranked, featureType: FeatureType.pick),
                    ],
                  ),
                  Row(
                    children: [
                      QueueHeaderCell(text: QueueType.others.name),
                      const QueueHeaderButtonSwitch(queueType: QueueType.others, featureType: FeatureType.queue),
                      const QueueHeaderButtonSwitch(queueType: QueueType.others, featureType: FeatureType.ban),
                      const QueueHeaderButtonSwitch(queueType: QueueType.others, featureType: FeatureType.pick),
                    ],
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
