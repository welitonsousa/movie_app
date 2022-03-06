import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import './movies_by_genre_controller.dart';

class MoviesByGenrePage extends GetView<MoviesByGenreController> {
  const MoviesByGenrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.genre.name)),
      body: Obx(_body),
    );
  }

  Widget _body() {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 330,
      ),
      itemCount: controller.movies.length,
      itemBuilder: (context, index) {
        controller.changeIndex(index);
        return Center(child: AppMovieCard(movie: controller.movies[index]));
      },
    );
  }
}
