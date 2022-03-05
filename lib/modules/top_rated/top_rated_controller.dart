import 'package:get/get.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class TopRatedController extends GetxController {
  final MovieRepository _moviesRepository;

  TopRatedController({
    required MovieRepository movieRepository,
  }) : _moviesRepository = movieRepository;

  final _genres = <GenreModel>[].obs;
  final _playingNow = <MovieModel>[].obs;
  final _topMovies = <MovieModel>[].obs;
  final _actors = <ActorModel>[].obs;
  final _loading = false.obs;

  List<MovieModel> get playingNow => [..._playingNow.sublist(0, 10)];
  List<MovieModel> get topMovies => [..._topMovies];
  List<GenreModel> get genres => [..._genres];
  List<ActorModel> get actors => [..._actors];
  bool get loading => _loading.value;

  Future<void> findAllGeneris() async {
    final res = await _moviesRepository.findAllGenre();
    genres.addAll(res);
  }

  Future<void> findPlayingNow() async {
    final res = await _moviesRepository.findPlayingNow();
    _playingNow.assignAll(res);
  }

  Future<void> findTopMovies() async {
    final res = await _moviesRepository.findTopMovies();
    _topMovies.assignAll(res);
  }

  Future<void> findActorsOfWeek() async {
    final res = await _moviesRepository.findActorsOfWeek();
    _actors.assignAll(res);
  }

  @override
  void onInit() async {
    _loading(true);
    await Future.wait([
      findAllGeneris(),
      findPlayingNow(),
      findTopMovies(),
      findActorsOfWeek()
    ]);
    _loading(false);
    super.onInit();
  }
}
