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
        elevation: 0,
        actions: [
          _buttonGenre(
              child: const Icon(Icons.favorite_border),
              color: context.theme.primaryColor,
              action: () => Get.toNamed(AppRouters.MOVIES_FAVORITES))
        ],
      ),
      body: Obx(() => _body(context)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () => Get.toNamed(AppRouters.SEARCH_MOVIES),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Visibility(
          visible: context.height >= 500,
          child: FadeInDownBig(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppCarousel(
                  labels: controller.playingNow.map((e) => e.title).toList(),
                  images: controller.playingNow.map((e) => e.picture).toList(),
                  height: 300,
                  onClick: (index) {
                    Get.toNamed(AppRouters.MOVIE_DETAIL,
                        arguments: controller.playingNow[index]);
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeInRightBig(child: _genres),
        const SizedBox(height: 10),
        Expanded(
          child: FadeInUpBig(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: controller.topMovies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.width ~/ 140,
                mainAxisSpacing: 5.0,
                mainAxisExtent: 265,
              ),
              itemBuilder: (c, index) {
                controller.getNextMovies(index);
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: Center(
                      child: AppMovieCard(movie: controller.topMovies[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
