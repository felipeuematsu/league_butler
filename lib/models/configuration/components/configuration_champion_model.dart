import 'package:hive/hive.dart';
import 'package:league_butler/models/data_dragon/champion/champion_model.dart';

part 'configuration_champion_model.g.dart';

@HiveType(typeId: 4)
class BanConfigurationChampionModel {
  BanConfigurationChampionModel();

  BanConfigurationChampionModel.fromChampionModel(ChampionModel model)
      : id = model.id,
        name = model.name,
        image = model.image?.square;

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;

}
