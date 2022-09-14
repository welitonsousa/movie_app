import 'package:get/get.dart';
import 'package:movie_app/core/utils/scroll_velocity.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class MoviesByGenreController extends GetxController {
  final MovieRepository _movieRepository;
  MoviesByGenreController({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  final GenreModel genre = Get.arguments;

  final _loading = false.obs;
  final _loadingMore = false.obs;
  final _movies = <MovieModel>[].obs;
  final scroll = ScrollVelocity.generate();

  int _page = 1;
  bool stopRequests = false;
  bool get loading => _loading.value;
  bool get loadingMore => _loadingMore.value;
  List<MovieModel> get movies => [..._movies];

  Future<void> _findMovies() async {
    if (!stopRequests) {
      final res =
          await _movieRepository.findMoviesByGenre(genre.id, page: _page);
      if (res.isEmpty) stopRequests = true;
      _movies.value = [..._movies, ...res];
    }
  }

  Future<void> changeIndex(int index) async {
    if (!stopRequests) {
      if (index == movies.length - 5 &&
          !loadingMore &&
          movies.length / 20 <= _page) {
        _page += 1;
        _loadingMore(true);
        await _findMovies();
        _loadingMore(false);
      }
    }
  }

  @override
  void onInit() async {
    _loading(true);
    _findMovies().then((value) => _loading(false));
    super.onInit();
  }

  @override
  void onClose() {
    scroll.dispose();
    super.onClose();
  }
}
