import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/main/features/feature_type.dart';
import 'package:league_butler/models/database/queue_configuration.dart';
import 'package:league_butler/models/lcu/queues.dart';

class QueueController extends GetxController {
  late Rx<QueueConfiguration> queueConfiguration;
  var currentQueueId = -1;

  bool get isQueueEnabled => queueConfiguration.value.isActivated;

  void toggleQueueConfig(QueueType queueType, FeatureType featureType) {
    switch (featureType) {
      case FeatureType.queue:
        switch (queueType) {
          case QueueType.ranked:
            queueConfiguration.update((val) => isQueueActivated(queueType, featureType) ? val?.activatedRankedFeatures.remove(featureType) : val?.activatedRankedFeatures.add(featureType));
            break;
          case QueueType.casual:
            queueConfiguration.update((val) => isQueueActivated(queueType, featureType) ? val?.activatedCasualFeatures.remove(featureType) : val?.activatedCasualFeatures.add(featureType));
            break;
          case QueueType.coopVsAI:
            queueConfiguration.update((val) => isQueueActivated(queueType, featureType) ? val?.activatedCoopFeatures.remove(featureType) : val?.activatedRankedFeatures.add(featureType));
            break;
          default:
            queueConfiguration.update((val) => isQueueActivated(queueType, featureType) ? val?.activatedOtherFeatures.remove(featureType) : val?.activatedOtherFeatures.add(featureType));
            break;
        }
        break;
      case FeatureType.pick:
      case FeatureType.ban:
        break;
    }
    Database().write(DatabaseKeys.queueConfiguration, queueConfiguration.value, persistent: true);
  }

  bool isQueueActivated(QueueType queueType, FeatureType featureType) {
    switch (featureType) {
      case FeatureType.queue:
        switch (queueType) {
          case QueueType.ranked:
            return queueConfiguration.value.activatedRankedFeatures.contains(featureType);
          case QueueType.casual:
            return queueConfiguration.value.activatedCasualFeatures.contains(featureType);
          case QueueType.coopVsAI:
            return queueConfiguration.value.activatedCoopFeatures.contains(featureType);
          default:
            return queueConfiguration.value.activatedOtherFeatures.contains(featureType);
        }
      case FeatureType.pick:
      case FeatureType.ban:
        return queueConfiguration.value.activatedOtherFeatures.contains(featureType);
    }
  }

  void toggleQueueStatus() => queueConfiguration.update((QueueConfiguration? config) {
        if (config == null) return;
        Database().write(DatabaseKeys.queueConfiguration, config..isActivated = !isQueueEnabled, persistent: true);
      });

  @override
  void onInit() async {
    queueConfiguration = (await Database().read<QueueConfiguration>(DatabaseKeys.queueConfiguration, persistent: true) ?? QueueConfiguration()).obs;
    super.onInit();
  }
}
