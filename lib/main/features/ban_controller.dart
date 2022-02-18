import 'package:get/get.dart';
import 'package:league_butler/database/database.dart';
import 'package:league_butler/database/database_keys.dart';
import 'package:league_butler/models/database/ban_configuration.dart';

class BanController extends GetxController {
  late final Rx<BanConfiguration> banConfiguration;

  bool get banStatus => banConfiguration.value.isActivated;

  void toggleBanStatus() => banConfiguration.update((config) async {
    if (config == null) return;
    config.isActivated = !banStatus;
    Database().write(DatabaseKeys.banConfiguration, config, persistent: true);
  });
  @override
  void onInit() async {
    banConfiguration = (await Database().read<BanConfiguration>(DatabaseKeys.banConfiguration, persistent: true) ?? BanConfiguration()).obs;
    super.onInit();
  }
}
