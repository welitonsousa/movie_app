import 'package:get/get.dart';
import './top_rated_controller.dart';

class TopRatedBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(TopRatedController());
    }
}