import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import './favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.movies.isEmpty) {
          return Center(
            child: Text(
              'Lista vazia',
              style: context.textTheme.headline5,
            ),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 330,
          ),
          itemCount: controller.movies.length,
          itemBuilder: (context, index) {
            return Center(child: AppMovieCard(movie: controller.movies[index]));
          },
        );
      }),
    );
  }
}
