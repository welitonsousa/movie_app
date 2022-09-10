import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import './movies_by_genre_controller.dart';

class MoviesByGenrePage extends GetView<MoviesByGenreController> {
  const MoviesByGenrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.genre.name),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(
            builder: (c, constrains) {
              return Obx(() => _body(c, constrains));
            },
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, BoxConstraints constraints) {
    if (controller.loading) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth ~/ 140,
          mainAxisExtent: 265,
          crossAxisSpacing: 5,
        ),
        controller: controller.scroll,
        itemCount: controller.movies.length,
        itemBuilder: (context, index) {
          controller.changeIndex(index);
          return Center(child: AppMovieCard(movie: controller.movies[index]));
        },
      ),
    );
  }
}
