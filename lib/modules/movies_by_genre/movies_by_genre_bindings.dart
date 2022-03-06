import 'package:get/get.dart';
import './movies_by_genre_controller.dart';

class MoviesByGenreBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MoviesByGenreController(movieRepository: Get.find()));
  }
}
