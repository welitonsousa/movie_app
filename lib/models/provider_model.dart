import 'package:movie_app/env.dart';

class ProviderModel {
  final String logo;
  final String name;
  final int id;
  final int priority;
  ProviderModel({
    required this.priority,
    required this.logo,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'logo_path': logo});
    result.addAll({'provider_name': name});
    result.addAll({'provider_id': id});
    result.addAll({'display_priority': priority});
    return result;
  }

  factory ProviderModel.fromMap(map) {
    return ProviderModel(
      priority: map['display_priority'] ?? 999,
      logo: Env.IMAGE_BASE + (map['logo_path']),
      name: map['provider_name'] ?? '',
      id: map['provider_id']?.toInt() ?? 0,
    );
  }
}
