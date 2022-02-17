import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/models/database/pick_configuration.dart';
import 'package:league_butler/utils/logger.dart';

class PickController extends GetxController {
  late Rx<PickConfiguration> pickConfiguration;

  bool get isPickEnabled => pickConfiguration.value.isActivated;

  set pickStatus(bool val) => pickConfiguration.update((config) async {
    if (config == null) return;
    config.isActivated = val;
    logger.i('saving pick configuration with ${pickConfiguration.value.isActivated}');
    Database().write(DatabaseKeys.pickConfiguration, config, persistent: true);
    logger.i('reading pick configuration: ${(await Database().read<PickConfiguration>(DatabaseKeys.pickConfiguration, persistent: true))?.isActivated}');
  });

  @override
  void onInit() async {
    pickConfiguration = (await Database().read<PickConfiguration>(DatabaseKeys.pickConfiguration, persistent: true) ?? PickConfiguration()).obs;
    super.onInit();
  }

  @override
  void onReady() {
    pickConfiguration.listen((configuration) {
      Database().write(DatabaseKeys.pickConfiguration, configuration, persistent: true);
    });
  }
}