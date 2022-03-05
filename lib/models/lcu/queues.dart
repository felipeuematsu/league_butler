import 'package:league_butler/screens/queue/queue_strings.dart';

enum Queue {
  blindPick,
  normal,
  soloQueue,
  flexQueue,
  custom,
  others,
}

enum QueueType {
  ranked,
  casual,
  coopVsAI,
  custom,
  others,
}

extension QueueExt on Queue {
  QueueType get type {
    switch (this) {
      case Queue.soloQueue:
      case Queue.flexQueue:
        return QueueType.ranked;
      case Queue.custom:
        return QueueType.custom;
      default:
        return QueueType.casual;
    }
  }
}

extension QueueTypeExt on QueueType {
  String get tr {
    switch (this) {
      case QueueType.ranked:
        return QueueStrings.ranked.tr;
      case QueueType.casual:
        return QueueStrings.casual.tr;
      case QueueType.custom:
      case QueueType.coopVsAI:
      case QueueType.others:
        return QueueStrings.others.tr;
    }
  }
}
