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
          : 'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
      picture: map['backdrop_path'] != null
          ? Env.IMAGE_BASE + map['backdrop_path']
          : 'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
      id: map['id']?.toInt() ?? 0,
      countAverage: map['vote_count']?.toInt() ?? 0,
      average: map['vote_average']?.toDouble() ?? 0.0,
    );
  }
}
