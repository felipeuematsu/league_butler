import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/features/ban_controller.dart';
import 'package:league_butler/main/features/pick_controller.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/models/lcu/summoner_model.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service.dart';

class StatusBarController extends GetxController {
  QueueController queueController = Get.find();
  BanController banController = Get.find();
  PickController pickController = Get.find();

  Rx<SummonerModel?> summoner = Rx<SummonerModel?>(null);

  DataDragonService dataDragonService = Get.find();

  late final queueStatus = queueController.isQueueEnabled.obs;
  late final banStatus = banController.banStatus.obs;
  late final pickStatus = pickController.isPickEnabled.obs;

  @override
  Future<void> onInit() async {
    summoner.value = await Get.find<LCUService>().getCurrentSummoner();
    super.onInit();
  }

  RxBool isActivated(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return queueStatus;
      case StatusBarItemType.ban:
        return banStatus;
      case StatusBarItemType.pick:
        return pickStatus;
    }
  }

  bool onTap(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return queueController.queueStatus = queueStatus.value = !queueStatus.value;
      case StatusBarItemType.ban:
        return banController.banStatus = banStatus.value = !banStatus.value;
      case StatusBarItemType.pick:
        return pickController.pickStatus = pickStatus.value = !pickStatus.value;
    }
  }

  IconData? getIcon(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return Icons.menu_open;
      case StatusBarItemType.ban:
        return Icons.block;
      case StatusBarItemType.pick:
        return Icons.lock;
    }
  }
}

enum StatusBarItemType {
  queue,
  ban,
  pick,
}
