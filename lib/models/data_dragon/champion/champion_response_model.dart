import 'package:league_butler/models/data_dragon/champion/champion_model.dart';

class ChampionResponseModel {
  ChampionResponseModel({this.type, this.format, this.version, this.data});

  ChampionResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    format = json['format'];
    version = json['version'];
    data = json['data'];
  }

  String? type;
  String? format;
  String? version;
  Map<String, ChampionModel>? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'format': format,
        'version': version,
        'data': data,
      };
}
