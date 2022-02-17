import 'package:hive/hive.dart';

part 'queue_configuration.g.dart';

@HiveType(typeId: 2)
class QueueConfiguration {
  @HiveField(0, defaultValue: false)
  var isActivated = false;
  @HiveField(1, defaultValue: [])
  List<int> activatedQueues = [];
  @HiveField(2, defaultValue: false)
  var rankedActivated = false;
}
