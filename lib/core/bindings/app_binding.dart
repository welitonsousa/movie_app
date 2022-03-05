import 'package:get/instance_manager.dart';
import 'package:movie_app/core/rest_client/dio_client.dart';
import 'package:movie_app/core/rest_client/rest_client.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestClient>(() => DioClient());
  }
}
