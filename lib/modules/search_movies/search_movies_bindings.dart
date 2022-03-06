import 'package:get/get.dart';
import './search_movies_controller.dart';

class SearchMoviesBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SearchMoviesController());
    }
}