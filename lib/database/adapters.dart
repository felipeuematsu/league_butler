import 'package:hive/hive.dart';
import 'package:league_butler/models/configuration/ban_configuration.dart';
import 'package:league_butler/models/configuration/components/configuration_champion_model.dart';
import 'package:league_butler/models/configuration/pick_configuration.dart';
import 'package:league_butler/models/configuration/queue_configuration.dart';

class DatabaseAdapters {
  static registerAdapters() {
    Hive.registerAdapter(BanConfigurationAdapter());
    Hive.registerAdapter(QueueConfigurationAdapter());
    Hive.registerAdapter(BanConfigurationChampionModelAdapter());
    Hive.registerAdapter(PickConfigurationAdapter());
  }
}
