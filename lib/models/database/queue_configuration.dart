import 'package:hive/hive.dart';
import 'package:league_butler/main/features/feature_type.dart';

part 'queue_configuration.g.dart';

@HiveType(typeId: 2)
class QueueConfiguration {
  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: [])
  List<FeatureType> activatedQueues = [];
  @HiveField(2, defaultValue: [])
  List<FeatureType> activatedRankedFeatures = [];
  @HiveField(3, defaultValue: [])
  List<FeatureType> activatedCoopFeatures = [];
  @HiveField(4, defaultValue: [])
  List<FeatureType> activatedCasualFeatures = [];
  @HiveField(5, defaultValue: [])
  List<FeatureType> activatedOtherFeatures = [];
}
