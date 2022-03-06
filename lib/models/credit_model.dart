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
          : 'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
      department: map['known_for_department'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }
}
