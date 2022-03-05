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
    const imageBase = 'https://image.tmdb.org/t/p/w300/';
    return MovieModel(
      title: map['title'] ?? '',
      description: map['overview'] ?? '',
      poster: imageBase + map['poster_path'],
      picture: imageBase + map['backdrop_path'],
      id: map['id']?.toInt() ?? 0,
      countAverage: map['vote_count']?.toInt() ?? 0,
      average: map['vote_average']?.toDouble() ?? 0.0,
    );
  }
}
