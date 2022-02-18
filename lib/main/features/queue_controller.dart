import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/models/database/queue_configuration.dart';
import 'package:league_butler/utils/logger.dart';

class QueueController extends GetxController {
  late Rx<QueueConfiguration> queueConfiguration;
  var currentQueueId = -1;

  bool get isQueueEnabled => queueConfiguration.value.isActivated;

  void toggleQueueStatus() => queueConfiguration.update((QueueConfiguration? config) async {
    logger.i(config);
    if (config == null) return;
    config.isActivated = !isQueueEnabled;
    logger.i('saving queue configuration with ${queueConfiguration.value.isActivated}');
    Database().write(DatabaseKeys.queueConfiguration, config, persistent: true);
    logger.i('reading queue configuration: ${(await Database().read<QueueConfiguration>(DatabaseKeys.queueConfiguration, persistent: true))?.isActivated}');
  });

  @override
  void onInit() async {
    queueConfiguration = (await Database().read<QueueConfiguration>(DatabaseKeys.queueConfiguration, persistent: true) ?? QueueConfiguration()).obs;
    super.onInit();
  }

  @override
  void onReady() {
    queueConfiguration.listen((configuration) {
      Database().write(DatabaseKeys.queueConfiguration, configuration, persistent: true);
    });
  }
}
