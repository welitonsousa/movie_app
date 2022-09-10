import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
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
        elevation: 0,
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
      body: Obx(() {
        if (controller.loading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return CustomScrollView(
          slivers: [
            if (context.height > 500)
              SliverAppBar(
                expandedHeight: 220,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: carousel(context),
                ),
              ),
            SliverAppBar(
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FadeInRightBig(child: _genres),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisExtent: 265,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  controller.getNextMovies(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AppMovieCard(movie: controller.topMovies[index]),
                  );
                },
                childCount: controller.topMovies.length,
              ),
            )
          ],
        );
      }),
    );
  }

  Widget carousel(BuildContext context) {
    if (context.height <= 500 || controller.playingNow.isEmpty) {
      return const SizedBox();
    }
    return FadeInDownBig(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AppCarousel(
          labels: controller.playingNow.map((e) => e.title).toList(),
          images: controller.playingNow.map((e) => e.picture).toList(),
          onClick: (index) {
            Get.toNamed(AppRouters.MOVIE_DETAIL,
                arguments: controller.playingNow[index]);
          },
        ),
      ),
    );
  }

  Widget get _genres {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      // height: 40,
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
      padding: const EdgeInsets.only(right: 10, top: 10),
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
