import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:get/get.dart';

class StatusBarController extends GetxController {
  final banStatus = false.obs;
  final queueStatus = false.obs;
  final pickStatus = false.obs;

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
        return queueStatus.value = !queueStatus.value;
      case StatusBarItemType.ban:
        return banStatus.value = !banStatus.value;
      case StatusBarItemType.pick:
        return pickStatus.value = !pickStatus.value;
    }
  }

  IconData? getIcon(StatusBarItemType type) {
    switch (type) {
      case StatusBarItemType.queue:
        return Icons.double_arrow_rounded;
      case StatusBarItemType.ban:
        return Icons.cancel;
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
