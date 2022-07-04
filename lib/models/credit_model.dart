import 'package:movie_app/env.dart';

class CreditModel {
  String name;
  String character;
  String picture;
  String department;
  int id;
  CreditModel({
    required this.name,
    required this.character,
    required this.picture,
    required this.department,
    required this.id,
  });

  factory CreditModel.fromMap(map) {
    return CreditModel(
      name: map['name'] ?? '',
      character: map['character'] ?? '',
      picture: map['profile_path'] != null
          ? Env.IMAGE_BASE + map['profile_path']
          : Env.IMAGE_AVATAR,
      department: map['known_for_department'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }
}
