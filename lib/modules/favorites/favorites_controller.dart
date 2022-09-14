import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/core/utils/scroll_velocity.dart';
import 'package:movie_app/models/movie_model.dart';

class FavoritesController extends GetxController {
  final _movies = <MovieModel>[].obs;
  final _storage = GetStorage();
  List<MovieModel> get movies => [..._movies];
  final scroll = ScrollVelocity.generate();

  @override
  void onInit() {
    _loadMovies();
    ever(_movies, (movies) => _saveMovies());
    super.onInit();
  }

  void _loadMovies() {
    var listJson = _storage.read('favorites');
    listJson ??= [];
    final res = listJson.map<MovieModel>(MovieModel.fromMap).toList();
    _movies.assignAll(res);
  }

  void addMovie(MovieModel movie) {
    final index = movies.indexWhere((element) => element.id == movie.id);
    if (index == -1) {
      _movies.add(movie);
    } else {
      _movies.removeAt(index);
    }
  }

  bool isFavorite(MovieModel movie) {
    final index = movies.indexWhere((element) => element.id == movie.id);
    return index > -1;
  }

  void _saveMovies() {
    final listJson = _movies.map((e) => e.toJson()).toList();
    _storage.write('favorites', listJson);
  }

  @override
  void onClose() {
    scroll.dispose();
    super.onClose();
  }
}
