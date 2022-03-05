import 'package:hive/hive.dart';
import 'package:league_butler/main/features/feature_type.dart';
import 'package:league_butler/models/database/ban_configuration.dart';
import 'package:league_butler/models/database/components/configuration_champion_model.dart';
import 'package:league_butler/models/database/lanes.dart';
import 'package:league_butler/models/database/pick_configuration.dart';
import 'package:league_butler/models/database/queue_configuration.dart';

class DatabaseAdapters {
  static registerAdapters() {
    Hive.registerAdapter(BanConfigurationAdapter());
    Hive.registerAdapter(QueueConfigurationAdapter());
    Hive.registerAdapter(BanConfigurationChampionModelAdapter());
    Hive.registerAdapter(PickConfigurationAdapter());
    Hive.registerAdapter(FeatureTypeAdapter());
    Hive.registerAdapter(LaneAdapter());
  }
}
