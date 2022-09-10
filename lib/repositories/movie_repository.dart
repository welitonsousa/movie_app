import 'package:movie_app/core/rest_client/rest_client.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/enums/country.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/provider_model.dart';
import 'package:movie_app/models/video_model.dart';

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

  Future<List<VideoModel>> findVideos(int id) async {
    final response = await _restClient.get('/movie/$id/videos');
    var res = response['results'].map<VideoModel>(VideoModel.fromMap).toList();
    res as List<VideoModel>;
    res.removeWhere((e) => e.platform != 'YouTube');
    return res;
  }

  Future<Map<Countries, List<ProviderModel>>> findMovieProviders(int id) async {
    Map<Countries, List<ProviderModel>> res = {};
    res.values;
    final response = await _restClient.get('/movie/$id/watch/providers');
    final payments = ['buy', 'flatrate', 'rent', 'ads'];

    for (var country in Countries.values) {
      List<ProviderModel> providers = [];

      for (var payment in payments) {
        providers = (response['results']?[country.name]?[payment] ?? [])
            .map<ProviderModel>(ProviderModel.fromMap)
            .toList() as List<ProviderModel>;
        providers.sort((a, b) => a.priority < b.priority ? 0 : 1);
        if (!res.containsKey(country)) res[country] = [];

        res[country]!.addAll(providers.where((e) {
          return res[country]?.indexWhere((p) => e.name == p.name) == -1;
        }).toList());
      }
    }
    return res;
  }

  Future<List<MovieModel>> findTopMovies({int page = 1}) async {
    final response = await _restClient.get('/discover/movie', params: {
      'page': page,
    });
    return response['results'].map<MovieModel>(MovieModel.fromMap).toList();
  }

  Future<List<MovieModel>> findMoviesByGenre(int id, {int page = 1}) async {
    final response = await _restClient.get('/discover/movie', params: {
      'with_genres': id,
      'page': page,
    });
    return response['results'].map<MovieModel>(MovieModel.fromMap).toList();
  }

  Future<List<MovieModel>> search(String word, {int page = 1}) async {
    if (word.isNotEmpty) {
      final response = await _restClient.get('/search/movie', params: {
        'query': word,
        'page': page,
      });
      return response['results'].map<MovieModel>(MovieModel.fromMap).toList();
    }
    return [];
  }

  Future<List<ActorModel>> findActorsOfWeek() async {
    final response = await _restClient.get('/trending/person/week');
    return response['results'].map<ActorModel>(ActorModel.fromMap).toList();
  }

  Future<List<CreditModel>> credits(int movieId) async {
    final response = await _restClient.get('/movie/$movieId/credits');
    return response['cast'].map<CreditModel>(CreditModel.fromMap).toList();
  }

  Future<List<MovieModel>> similar(int movieId) async {
    var response = await _restClient.get('/movie/$movieId/similar');
    var res = response['results'].map<MovieModel>(MovieModel.fromMap).toList();
    res as List<MovieModel>;
    res.removeWhere((element) => element.id == movieId);
    return res;
  }
}
