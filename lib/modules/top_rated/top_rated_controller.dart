import 'package:get/get.dart';
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
  final _loading = false.obs;

  List<MovieModel> get playingNow => [..._playingNow];
  List<MovieModel> get topMovies => [..._topMovies];
  List<GenreModel> get genres => [..._genres];
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
    _topMovies.assignAll(res.sublist(0, 10));
  }

  @override
  void onInit() async {
    _loading(true);
    await Future.wait([findAllGeneris(), findPlayingNow(), findTopMovies()]);
    _loading(false);
    super.onInit();
  }
}
