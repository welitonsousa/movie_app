class VideoModel {
  final String name;
  final String key;
  final String platform;
  final String id;
  final String type;
  VideoModel({
    required this.name,
    required this.key,
    required this.platform,
    required this.id,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'key': key});
    result.addAll({'site': platform});
    result.addAll({'id': id});
    result.addAll({'type': type});

    return result;
  }

  factory VideoModel.fromMap(map) {
    return VideoModel(
      name: map['name'] ?? '',
      key: map['key'] ?? '',
      platform: map['site'] ?? '',
      id: map['id'] ?? '',
      type: map['type'] ?? '',
    );
  }
}
