import 'package:movie_app/core/rest_client/rest_client.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieRepository {
  final RestClient _restClient;
  MovieRepository({required RestClient restClient}) : _restClient = restClient;

  Future<List<GenreModel>> findAllGenre() async {
    final response = await _restClient.get('/genre/movie/list');
    return response['genres'].map<GenreModel>(GenreModel.fromMap).toList();
  }

  Future<List<MovieModel>> findPlayingNow() async {
    final response = await _restClient.get('/movie/now_playing');
    return response['results'].map<MovieModel>(MovieModel.fromMap).toList();
  }

  Future<List<MovieModel>> findTopMovies() async {
    final response = await _restClient.get('/movie/top_rated');
    return response['results'].map<MovieModel>(MovieModel.fromMap).toList();
  }
}
