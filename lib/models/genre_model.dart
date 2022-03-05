class GenreModel {
  int id;
  String name;
  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromMap(dynamic map) {
    return GenreModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }
}
