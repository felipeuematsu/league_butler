import 'package:hive/hive.dart';

part 'lanes.g.dart';

@HiveType(typeId: 5)
enum Lane {
  @HiveField(0)
  top,
  @HiveField(1)
  mid,
  @HiveField(2)
  bot,
  @HiveField(3)
  jungle,
  @HiveField(4)
  support,
  @HiveField(5, defaultValue: true)
  otherOrAny,
}