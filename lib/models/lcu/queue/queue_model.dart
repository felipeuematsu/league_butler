import 'package:league_butler/models/lcu/queues.dart';

class QueueModel {
  QueueModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        isRanked = map['isRanked'],
        category = map['category'],
        queueAvailability = map['queueAvailability'],
        isAvailable = map['category'] == 'Available';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'isRanked': isRanked,
        'category': category,
        'queueAvailability': queueAvailability,
      };
  int? id;
  String? name;
  String? description;
  bool? isRanked;
  String? category;
  String? queueAvailability;
  bool? isAvailable;
}

extension QueueModelExt on QueueModel {
  Queue get queue {
    switch (id) {
      case 0:
        return Queue.custom;
      case 400:
        return Queue.normal;
      case 420:
        return Queue.soloQueue;
      case 440:
        return Queue.flexQueue;
      case 430:
        return Queue.blindPick;
      default:
        return Queue.others;
    }
  }
}