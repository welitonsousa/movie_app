import 'package:get/get.dart';
import 'package:movie_app/repositories/movie_repository.dart';
import './top_rated_controller.dart';

class TopRatedBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MovieRepository(restClient: Get.find()));
    Get.put(TopRatedController(movieRepository: Get.find()));
  }
}
