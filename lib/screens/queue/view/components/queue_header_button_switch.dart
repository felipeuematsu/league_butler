import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/commons/strings.dart';
import 'package:league_butler/main/features/feature_type.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/models/lcu/queues.dart';
import 'package:league_butler/screens/queue/view/components/queue_header_cell.dart';

class QueueHeaderButtonSwitch extends GetView<QueueController> {
  const QueueHeaderButtonSwitch({Key? key, required this.queueType, required this.featureType}) : super(key: key);

  final QueueType queueType;
  final FeatureType featureType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Obx(() => MaterialButton(
        color: controller.isQueueActivated(queueType, featureType) ? Colors.greenAccent.withOpacity(0.4) : Get.theme.colorScheme.surfaceVariant.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            height: 100,
            minWidth: QueueHeaderCell.width - 2 * 6,
            elevation: 2,
            onPressed: () => controller.toggleQueueConfig(queueType, featureType),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(queueType.tr, style: Get.textTheme.labelLarge),
                  Text(controller.isQueueActivated(queueType, featureType) ? CommonStrings.activated.tr : CommonStrings.deactivated.tr,
                      style: Get.textTheme.labelSmall?.copyWith(color: controller.isQueueActivated(queueType, featureType) ? Get.theme.colorScheme.onPrimary : Get.theme.colorScheme.secondary)),
                ],
              ),
            ),
          )),
    );
  }
}
