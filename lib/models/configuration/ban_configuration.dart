import 'package:hive/hive.dart';
import 'package:league_butler/models/data_dragon/champion/champion_model.dart';
import 'package:league_butler/models/configuration/lanes.dart';

part 'ban_configuration.g.dart';

@HiveType(typeId: 1)
class BanConfiguration {
  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: {})
  Map<Lane, List<ChampionModel>> champions = {};
}
