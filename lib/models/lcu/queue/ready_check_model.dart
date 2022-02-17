class ReadyCheckModel {
  ReadyCheckModel({this.dodgeWarning, this.playerResponse, this.state, this.suppressUx, this.timer = 0});

  ReadyCheckModel.fromJson(Map<String, dynamic> json) :
    dodgeWarning = json['dodgeWarning'],
    playerResponse = json['playerResponse'],
    state = json['state'],
    suppressUx = json['suppressUx'],
    timer = json['timer'] ?? 0.0;

  String? dodgeWarning;
  String? playerResponse;
  String? state;
  bool? suppressUx;
  double timer;

  Map<String, dynamic> toJson() => {
        'dodgeWarning': dodgeWarning,
        'playerResponse': playerResponse,
        'state': state,
        'suppressUx': suppressUx,
        'timer': timer,
      };
}
