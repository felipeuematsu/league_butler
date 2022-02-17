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
