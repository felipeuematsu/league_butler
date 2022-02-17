import 'package:hive/hive.dart';
import 'package:league_butler/models/data_dragon/champion/champion_model.dart';
import 'package:league_butler/models/database/lanes.dart';

part 'pick_configuration.g.dart';

@HiveType(typeId: 3)
class PickConfiguration {

  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: {})
  Map<Lane, List<ChampionModel>> champions = {};
}