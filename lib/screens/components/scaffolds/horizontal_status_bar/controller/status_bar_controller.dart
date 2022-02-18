import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:league_butler/main/features/ban_controller.dart';
import 'package:league_butler/main/features/pick_controller.dart';
import 'package:league_butler/main/features/queue_controller.dart';
import 'package:league_butler/models/lcu/summoner_model.dart';
import 'package:league_butler/screens/queue/queue_strings.dart';
import 'package:league_butler/service/data_dragon_service.dart';
import 'package:league_butler/service/lcu_service/lcu_service.dart';

class StatusBarController extends GetxController {
  QueueController queueController = Get.find();
  BanController banController = Get.find();
  PickController pickController = Get.find();

  Rx<SummonerModel?> summoner = Rx<SummonerModel?>(null);

  DataDragonService dataDragonService = Get.find();

  @override
  Future<void> onInit() async {
    summoner.value = await Get.find<LCUService>().getCurrentSummoner();
    super.onInit();
  }

  bool isActivated(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return queueController.isQueueEnabled;
      case StatusBarItemType.ban:
        return banController.banStatus;
      case StatusBarItemType.pick:
        return pickController.isPickEnabled;
    }
  }

  String getButtonText(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return QueueStrings.queue.tr;
      case StatusBarItemType.ban:
        return 'Ban';
      case StatusBarItemType.pick:
        return 'Pick';
    }
  }

  void onTap(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return queueController.toggleQueueStatus();
      case StatusBarItemType.ban:
        return banController.toggleBanStatus();
      case StatusBarItemType.pick:
        return pickController.togglePickStatus();
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

extension StatusBarItemTypeExt on StatusBarItemType {
  String get name {
    switch (this) {
      case StatusBarItemType.queue:
        return 'Queue';
      case StatusBarItemType.ban:
        return 'Ban';
      case StatusBarItemType.pick:
        return 'Pick';
    }
  }
}