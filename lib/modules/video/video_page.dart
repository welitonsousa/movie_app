import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import './video_controller.dart';

class VideoPage extends GetView<VideoController> {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.orientation == Orientation.portrait
          ? AppBar(title: Text(controller.movie.title), elevation: 0)
          : null,
      body: Obx(() => body(context)),
    );
  }

  Widget body(BuildContext context) {
    if (controller.loading.value) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (controller.videos.isEmpty) {
      return const Center(child: Text("Nenhum trailer encontrado"));
    }

    return ListView.builder(
      controller: controller.scrollController,
      itemCount: controller.videos.length,
      physics: context.orientation == Orientation.landscape
          ? const NeverScrollableScrollPhysics()
          : null,
      itemBuilder: (c, i) {
        return SizedBox(
          height: context.orientation == Orientation.landscape
              ? context.height
              : null,
          width: context.orientation == Orientation.landscape
              ? context.width
              : null,
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                const PlaybackSpeedButton(),
                const SizedBox(width: 20),
                RemainingDuration(),
                IconButton(
                  onPressed: () async {
                    controller.videoControllers[i].toggleFullScreenMode();
                    if (context.orientation == Orientation.portrait) {
                      await controller.scrollController.animateTo(
                        i * context.width,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                      controller.videoControllers[i].play();
                    }
                  },
                  icon: const Icon(Icons.fullscreen),
                )
              ],
              topActions: [
                Visibility(
                  visible: context.orientation == Orientation.landscape,
                  child: IconButton(
                    onPressed: () {
                      SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.portraitUp]);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                )
              ],
              controller: controller.videoControllers[i],
              showVideoProgressIndicator: true,
            ),
            builder: ((p0, p1) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: p1),
                    const SizedBox(height: 5),
                    Text(controller.videos[i].name,
                        style: context.textTheme.headline6),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
