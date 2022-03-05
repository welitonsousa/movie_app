import 'package:movie_app/env.dart';

class ActorModel {
  String name;
  String picture;
  int id;
  ActorModel({
    required this.name,
    required this.picture,
    required this.id,
  });

  factory ActorModel.fromMap(map) {
    return ActorModel(
      name: map['name'] ?? '',
      picture: Env.IMAGE_BASE + map['profile_path'],
      id: map['id']?.toInt() ?? 0,
    );
  }
}
