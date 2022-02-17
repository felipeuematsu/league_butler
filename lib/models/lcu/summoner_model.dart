class SummonerModel {
  SummonerModel({
    accountId,
    displayName,
    internalName,
    nameChangeFlag,
    percentCompleteForNextLevel,
    privacy,
    profileIconId,
    puuid,
    summonerId,
    summonerLevel,
    unnamed,
    xpSinceLastLevel,
    xpUntilNextLevel,
  });

  SummonerModel.fromJson(Map<String, dynamic> json)
      : accountId = json['accountId'],
        displayName = json['displayName'],
        internalName = json['internalName'],
        nameChangeFlag = json['nameChangeFlag'],
        percentCompleteForNextLevel = json['percentCompleteForNextLevel'],
        privacy = json['privacy'],
        profileIconId = json['profileIconId'],
        puuid = json['puuid'],
        summonerId = json['summonerId'],
        summonerLevel = json['summonerLevel'],
        unnamed = json['unnamed'],
        xpSinceLastLevel = json['xpSinceLastLevel'],
        xpUntilNextLevel = json['xpUntilNextLevel'];

  int? accountId;
  String? displayName;
  String? internalName;
  bool? nameChangeFlag;
  int? percentCompleteForNextLevel;
  String? privacy;
  int? profileIconId;
  String? puuid;
  int? summonerId;
  int? summonerLevel;
  bool? unnamed;
  int? xpSinceLastLevel;
  int? xpUntilNextLevel;

  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'displayName': displayName,
        'internalName': internalName,
        'nameChangeFlag': nameChangeFlag,
        'percentCompleteForNextLevel': percentCompleteForNextLevel,
        'privacy': privacy,
        'profileIconId': profileIconId,
        'puuid': puuid,
        'summonerId': summonerId,
        'summonerLevel': summonerLevel,
        'unnamed': unnamed,
        'xpSinceLastLevel': xpSinceLastLevel,
        'xpUntilNextLevel': xpUntilNextLevel,
      };
}
