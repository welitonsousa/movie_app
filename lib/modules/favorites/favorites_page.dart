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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Obx(() {
            if (controller.movies.isEmpty) {
              return Center(
                child: Text('Lista vazia', style: context.textTheme.headline5),
              );
            }
            return LayoutBuilder(
              builder: (c, constraints) => Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: controller.movies.length,
                  controller: controller.scroll,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth ~/ 140,
                    mainAxisExtent: 265,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (c, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AppMovieCard(movie: controller.movies[index]),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
