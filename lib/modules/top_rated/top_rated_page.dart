import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/app_carousel.dart';
import './top_rated_controller.dart';

class TopRatedPage extends GetView<TopRatedController> {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Obx(() => _body()),
    );
  }

  Widget _body() {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        AppCarousel(
          labels: controller.topMovies.map((e) => e.title).toList(),
          images: controller.topMovies.map((e) => e.picture).toList(),
        ),
      ],
    );
  }
}
