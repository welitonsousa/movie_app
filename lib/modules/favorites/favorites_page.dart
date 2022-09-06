import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import './favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos'), elevation: 0),
      body: Obx(() {
        if (controller.movies.isEmpty) {
          return Center(
            child: Text('Lista vazia', style: context.textTheme.headline5),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: controller.movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.width ~/ 140,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 10,
            mainAxisExtent: 265,
          ),
          itemBuilder: (c, index) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 140),
                child: Center(
                  child: AppMovieCard(movie: controller.movies[index]),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
