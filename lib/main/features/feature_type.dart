import 'package:hive/hive.dart';

part 'feature_type.g.dart';

@HiveType(typeId: 6)
enum FeatureType {
  @HiveField(0)
  queue,
  @HiveField(1)
  pick,
  @HiveField(2)
  ban
}
