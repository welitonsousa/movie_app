import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  final _repository = Get.find<MovieRepository>();

  final movie = Get.arguments as MovieModel;
  final videos = <VideoModel>[];
  final videoControllers = <YoutubePlayerController>[];
  final loading = false.obs;
  final scrollController = ScrollController();

  Future<void> findVideos() async {
    try {
      loading(true);
      final res = await _repository.findVideos(movie.id);
      videos.assignAll(res);
      closeAllYoutubeControllers();
      videoControllers.assignAll(
        videos.map((e) => YoutubePlayerController(
              initialVideoId: e.key,
              flags: const YoutubePlayerFlags(autoPlay: false),
            )),
      );
    } finally {
      loading(false);
    }
  }

  void closeAllYoutubeControllers() {
    for (var e in videoControllers) {
      e.dispose();
    }
    videoControllers.clear();
  }

  @override
  void onInit() {
    findVideos();
    super.onInit();
  }

  @override
  void onClose() {
    closeAllYoutubeControllers();
    scrollController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.onClose();
  }
}
