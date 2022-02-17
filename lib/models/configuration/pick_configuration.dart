import 'package:hive/hive.dart';
import 'package:league_butler/models/configuration/lanes.dart';
import 'package:league_butler/models/data_dragon/champion/champion_model.dart';

part 'pick_configuration.g.dart';

@HiveType(typeId: 3)
class PickConfiguration {

  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: {})
  Map<Lane, List<ChampionModel>> champions = {};
}