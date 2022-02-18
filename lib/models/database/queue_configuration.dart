import 'package:hive/hive.dart';

part 'queue_configuration.g.dart';

@HiveType(typeId: 2)
class QueueConfiguration {
  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: [])
  List<int> deactivatedQueues = [];
  @HiveField(2, defaultValue: false)
  var rankedActivated = false;
  @HiveField(3, defaultValue: false)
  var coopVsIaActivated = false;
  @HiveField(4, defaultValue: false)
  var casualActivated = false;
}
