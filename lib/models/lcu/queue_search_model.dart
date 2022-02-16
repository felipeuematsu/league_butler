class QueueSearchModel {
  QueueSearchModel({this.dodgeData, this.estimatedQueueTime, this.isCurrentlyInQueue, this.lobbyId, this.lowPriorityData, this.queueId, this.readyCheck, this.searchState, this.timeInQueue});

  QueueSearchModel.fromJson(Map<String, dynamic> json) {
    dodgeData = json['dodgeData'] != null ? DodgeData.fromJson(json['dodgeData']) : null;

    estimatedQueueTime = json['estimatedQueueTime'];
    isCurrentlyInQueue = json['isCurrentlyInQueue'];
    lobbyId = json['lobbyId'];
    lowPriorityData = json['lowPriorityData'] != null ? LowPriorityData.fromJson(json['lowPriorityData']) : null;
    queueId = json['queueId'];
    readyCheck = json['readyCheck'] != null ? ReadyCheck.fromJson(json['readyCheck']) : null;
    searchState = json['searchState'];
    timeInQueue = json['timeInQueue'];
  }

  DodgeData? dodgeData;
  double? estimatedQueueTime;
  bool? isCurrentlyInQueue;
  String? lobbyId;
  LowPriorityData? lowPriorityData;
  int? queueId;
  ReadyCheck? readyCheck;
  String? searchState;
  int? timeInQueue;

  Map<String, dynamic> toJson() => {
        'dodgeData': dodgeData?.toJson(),
        'estimatedQueueTime': estimatedQueueTime,
        'isCurrentlyInQueue': isCurrentlyInQueue,
        'lobbyId': lobbyId,
        'lowPriorityData': lowPriorityData?.toJson(),
        'queueId': queueId,
        'readyCheck': readyCheck?.toJson(),
        'searchState': searchState,
        'timeInQueue': timeInQueue,
      };
}

class DodgeData {
  DodgeData({this.dodgerId, this.state});

  DodgeData.fromJson(Map<String, dynamic> json)
      : dodgerId = json['dodgerId'],
        state = json['state'];

  int? dodgerId;
  String? state;

  Map<String, dynamic> toJson() => {
        'dodgerId': dodgerId,
        'state': state,
      };
}

class LowPriorityData {
  LowPriorityData({this.bustedLeaverAccessToken, this.penaltyTime, this.penaltyTimeRemaining, this.reason});

  LowPriorityData.fromJson(Map<String, dynamic> json)
      : bustedLeaverAccessToken = json['bustedLeaverAccessToken'],
        penaltyTime = json['penaltyTime'],
        penaltyTimeRemaining = json['penaltyTimeRemaining'],
        reason = json['reason'];

  String? bustedLeaverAccessToken;
  int? penaltyTime;
  int? penaltyTimeRemaining;
  String? reason;

  Map<String, dynamic> toJson() => {
        'bustedLeaverAccessToken': bustedLeaverAccessToken,
        'penaltyTime': penaltyTime,
        'penaltyTimeRemaining': penaltyTimeRemaining,
        'reason': reason,
      };
}

class ReadyCheck {
  ReadyCheck({this.dodgeWarning, this.playerResponse, this.state, this.suppressUx, this.timer});

  ReadyCheck.fromJson(Map<String, dynamic> json)
      : dodgeWarning = json['dodgeWarning'],
        playerResponse = json['playerResponse'],
        state = json['state'],
        suppressUx = json['suppressUx'],
        timer = json['timer'];

  String? dodgeWarning;
  String? playerResponse;
  String? state;
  bool? suppressUx;
  int? timer;

  Map<String, dynamic> toJson() => {
        'dodgeWarning': dodgeWarning,
        'playerResponse': playerResponse,
        'state': state,
        'suppressUx': suppressUx,
        'timer': timer,
      };
}
