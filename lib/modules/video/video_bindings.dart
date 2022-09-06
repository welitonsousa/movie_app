import 'package:get/get.dart';
import './video_controller.dart';

class VideoBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(VideoController());
    }
}