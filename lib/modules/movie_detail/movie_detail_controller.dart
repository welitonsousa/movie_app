import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/core/utils/scroll_velocity.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/enums/country.dart';
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
  final _storage = GetStorage();
  final providers = <Countries, List<ProviderModel>>{}.obs;
  final country = Countries.BR.obs;
  final scroll = ScrollVelocity.generate();
  final horizontalScroll = ScrollVelocity.generate();

  MovieModel get movie => _movie.value;
  List<CreditModel> get credits => [..._credits];
  List<MovieModel> get moviesSimilares => [..._similares];

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
    providers.assignAll(res);
  }

  Future<void> changeCountry(Countries? v) async {
    if (v != null) {
      country.value = v;
      await _storage.write('country', v.index);
    }
  }

  @override
  void onReady() {
    Future.wait([movieCredits(), movieSimilares(), movieProviders()]);
    super.onReady();
  }

  @override
  void onClose() {
    scroll.dispose();
    horizontalScroll.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    final res = (_storage.read('country') as int?);
    if (res != null) country.value = Countries.values[res];
    super.onInit();
  }
}
