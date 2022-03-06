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
      appBar: AppBar(title: const Text('Movies')),
      body: Obx(() => _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        FadeInDownBig(
          child: AppCarousel(
            labels: controller.playingNow.map((e) => e.title).toList(),
            images: controller.playingNow.map((e) => e.picture).toList(),
          ),
        ),
        const SizedBox(height: 10),
        FadeInRightBig(child: _genres),
        FadeInUpBig(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: controller.topMovies
                  .map((e) => AppMovieCard(movie: e))
                  .toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 10),
          child: Text('Atores da Semana', style: context.textTheme.headline6),
        ),
        _actorsComponent
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
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ElevatedButton(
                child: Text(controller.genres[index].name),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 67, 30, 170)),
                ),
                onPressed: () {
                  Get.toNamed(
                    AppRouters.MOVIES_BY_GENRES,
                    arguments: controller.genres[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _actorsComponent {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: controller.actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                controller.actors[index].picture,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
