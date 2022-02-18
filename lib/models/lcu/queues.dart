

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
