import 'package:get/get.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/provider_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class MovieDetailController extends GetxController {
  final MovieRepository _repository;
  MovieDetailController({required MovieRepository repository})
      : _repository = repository;

  final _movie = Rx<MovieModel>(Get.arguments);
  final _credits = <CreditModel>[].obs;
  final _similares = <MovieModel>[].obs;
  final _providers = <ProviderModel>[].obs;

  MovieModel get movie => _movie.value;
  List<CreditModel> get credits => [..._credits];
  List<MovieModel> get moviesSimilares => [..._similares];
  List<ProviderModel> get providers => [..._providers];

  Future<void> movieCredits() async {
    final res = await _repository.credits(movie.id);
    _credits.assignAll(res);
  }

  Future<void> movieSimilares() async {
    final res = await _repository.similar(movie.id);
    _similares.assignAll(res);
  }

  Future<void> movieProviders() async {
    final res = await _repository.findMovieProviders(movie.id);
    _providers.assignAll(res);
  }

  @override
  void onReady() {
    Future.wait([movieCredits(), movieSimilares(), movieProviders()]);
    super.onReady();
  }
}
