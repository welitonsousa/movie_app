import 'package:movie_app/env.dart';

class MovieModel {
  String title;
  String description;
  String poster;
  String picture;
  int id;
  int countAverage;
  double average;
  MovieModel({
    required this.title,
    required this.description,
    required this.poster,
    required this.picture,
    required this.id,
    required this.countAverage,
    required this.average,
  });

  factory MovieModel.fromMap(map) {
    return MovieModel(
      title: map['title'] ?? '',
      description: map['overview'] ?? '',
      poster: map['poster_path'] != null
          ? Env.IMAGE_BASE + map['poster_path']
          : Env.IMAGE_AVATAR,
      picture: map?['backdrop_path'] != null
          ? Env.IMAGE_BASE + map['backdrop_path']
          : Env.IMAGE_AVATAR,
      id: map['id']?.toInt() ?? 0,
      countAverage: map['vote_count']?.toInt() ?? 0,
      average: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'overview': description,
      'poster_path': poster.replaceAll(Env.IMAGE_BASE, ''),
      'backdrop_path': picture.replaceAll(Env.IMAGE_BASE, ''),
      'vote_count': countAverage,
      'vote_average': average,
    };
  }
}
