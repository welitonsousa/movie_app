import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/app_carousel.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import 'package:movie_app/router/app_router.dart';
import './top_rated_controller.dart';

class TopRatedPage extends GetView<TopRatedController> {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        actions: [
          _buttonGenre(
              child: const Icon(Icons.favorite_border),
              color: context.theme.primaryColor,
              action: () => Get.toNamed(AppRouters.MOVIES_FAVORITES))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () => Get.toNamed(AppRouters.SEARCH_MOVIES),
      ),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: carousel(context),
              ),
            ),
            SliverAppBar(
              expandedHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: FadeInRightBig(child: _genres),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisExtent: 265,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  controller.getNextMovies(index);
                  return AppMovieCard(
                    movie: controller.topMovies[index],
                    // size: 260,
                  );
                },
                childCount: controller.topMovies.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget carousel(BuildContext context) {
    if (context.height <= 700 || controller.playingNow.isEmpty) {
      return const SizedBox();
    }
    return FadeInDownBig(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppCarousel(
                labels: controller.playingNow.map((e) => e.title).toList(),
                images: controller.playingNow.map((e) => e.picture).toList(),
                onClick: (index) {
                  Get.toNamed(AppRouters.MOVIE_DETAIL,
                      arguments: controller.playingNow[index]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _genres {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.genres.length,
          itemBuilder: (c, i) {
            return _buttonGenre(
              child: Text(controller.genres[i].name),
              action: () {
                Get.toNamed(
                  AppRouters.MOVIES_BY_GENRES,
                  arguments: Get.toNamed(
                    AppRouters.MOVIES_BY_GENRES,
                    arguments: controller.genres[i],
                  ),
                );
              },
            );
          }),
    );
  }

  Widget _buttonGenre({
    required Widget child,
    required void Function() action,
    Color color = const Color.fromARGB(255, 67, 30, 170),
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ElevatedButton(
          child: child,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          onPressed: action,
        ),
      ),
    );
  }
}
