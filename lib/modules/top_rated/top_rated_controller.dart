import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/core/utils/scroll_velocity.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class TopRatedController extends GetxController {
  final MovieRepository _moviesRepository;
  final _storage = GetStorage();
  TopRatedController({
    required MovieRepository movieRepository,
  }) : _moviesRepository = movieRepository;

  final _genres = <GenreModel>[].obs;
  final _playingNow = <MovieModel>[].obs;
  final _topMovies = <MovieModel>[].obs;
  final _actors = <ActorModel>[].obs;
  final _loading = false.obs;
  final _page = 1.obs;
  final _loadingNextPage = false.obs;
  final scroll = ScrollVelocity.generate();

  List<MovieModel> get playingNow => [..._playingNow];
  List<MovieModel> get topMovies => [..._topMovies];
  List<GenreModel> get genres => [..._genres];
  List<ActorModel> get actors => [..._actors];
  bool get loading => _loading.value;
  bool stopRequests = false;

  Future<void> findPlayingNow() async {
    try {
      final res = await _moviesRepository.findPlayingNow();

      _playingNow.assignAll(res);
      _storage.write(
          'playing-movies', _topMovies.map((e) => e.toJson()).toList());
    } catch (e) {
      final movies = _storage.read('playing-movies');
      if (_playingNow.isEmpty) {
        _playingNow
            .assignAll(movies.map<MovieModel>(MovieModel.fromMap).toList());
      }
    }
  }

  Future<void> findTopMovies() async {
    try {
      final res = await _moviesRepository.findTopMovies(page: _page.value);
      if (res.isEmpty) stopRequests = true;
      _topMovies.value = [..._topMovies, ...res];
      _storage.write('top-movies', _topMovies.map((e) => e.toJson()).toList());
    } catch (e) {
      final top = _storage.read('top-movies');
      if (_topMovies.isEmpty) {
        _topMovies.assignAll(top.map<MovieModel>(MovieModel.fromMap).toList());
      }
    }
  }

  Future<void> findActorsOfWeek() async {
    // final res = await _moviesRepository.findActorsOfWeek();
    // _actors.assignAll(res);
  }

  Future<void> findAllGenres() async {
    final local = _storage.read('genres');
    if (local == null) {
      final res = await _moviesRepository.findAllGenre();
      await _storage.write('genres', res.map((e) => e.toMap()).toList());
      _genres.assignAll(res);
    } else {
      _genres.assignAll(local.map<GenreModel>(GenreModel.fromMap).toList());
    }
  }

  Future<void> getNextMovies(int index) async {
    if (!stopRequests) {
      if (index == _topMovies.length - 10) {
        if (!_loadingNextPage.value) {
          _page.value += 1;
          await findTopMovies();
        }
      }
    }
  }

  @override
  void onInit() async {
    _loading(true);
    try {
      await Future.wait([
        findPlayingNow(),
        findTopMovies(),
        findActorsOfWeek(),
        findAllGenres(),
      ]);
      _loading(false);
    } catch (e) {
      _loading(false);
    }
    super.onInit();
  }

  @override
  void onClose() {
    scroll.dispose();
    super.onClose();
  }
}
