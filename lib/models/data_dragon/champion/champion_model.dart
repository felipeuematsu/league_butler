class ChampionModel {
  ChampionModel({this.version, this.id, this.key, this.name, this.title, this.image});

  ChampionModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        id = json['id'],
        key = json['key'],
        name = json['name'],
        title = json['title'],
        image = Image.fromJson(json['image'] ?? {});

  String? version;
  String? id;
  String? key;
  String? name;
  String? title;
  Image? image;

  Map<String, dynamic> toJson() => {
        'version': version,
        'id': id,
        'key': key,
        'name': name,
        'title': title,
        'image': image?.toJson(),
      };
}

class Image {
  Image({this.square, this.sprite, this.group});

  Image.fromJson(Map<String, dynamic> json)
      : square = json['full'],
        sprite = json['sprite'],
        group = json['group'];

  String? square;
  String? sprite;
  String? group;
  Map<String, dynamic> toJson() => {
        'full': square,
        'sprite': sprite,
        'group': group,
      };
}
