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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }
}
