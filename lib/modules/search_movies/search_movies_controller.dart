import 'dart:async';

import 'package:get/get.dart';
import 'package:movie_app/core/utils/scroll_velocity.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class SearchMoviesController extends GetxController {
  final MovieRepository _movieRepository;
  SearchMoviesController({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final _loading = false.obs;
  final _loadingMore = false.obs;
  final _movies = <MovieModel>[].obs;
  final _search = "".obs;
  final scroll = ScrollVelocity.generate();

  Timer? _debounce;

  int _page = 1;
  bool stopRequests = false;
  bool get loading => _loading.value;
  bool get loadingMore => _loadingMore.value;
  String get search => _search.value;
  List<MovieModel> get movies => [..._movies];

  Future<void> _findMovies(String word) async {
    final res = await _movieRepository.search(word, page: _page);
    if (res.isEmpty) stopRequests = true;
    _movies.assignAll(res);
  }

  Future<void> changeIndex(int index) async {
    if (!stopRequests) {
      if (index == movies.length - 5 &&
          !loadingMore &&
          movies.length / 20 <= _page) {
        _page += 1;
        _loadingMore(true);
        final res = await _movieRepository.search(_search.value, page: _page);
        if (res.isEmpty) stopRequests = true;
        _movies.value = [..._movies, ...res];
        _loadingMore(false);
      }
    }
  }

  Future<void> onChange(String value) async {
    _search.value = value;
  }

  @override
  void onInit() {
    ever(_search, (word) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        _page = 1;
        stopRequests = false;
        await _findMovies(_search.value);
      });
    });
    super.onInit();
  }

  @override
  void onClose() {
    scroll.dispose();
    super.onClose();
  }
}
