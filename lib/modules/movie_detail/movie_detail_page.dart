import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/app_rating.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/modules/favorites/favorites_controller.dart';
import './movie_detail_controller.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailController controller;
  final favoriteController = Get.find<FavoritesController>();
  @override
  void initState() {
    final movie = Rx<MovieModel>(Get.arguments);
    final tag = movie.value.id.toString();
    Get.put(MovieDetailController(repository: Get.find()), tag: tag);
    controller = Get.find<MovieDetailController>(tag: tag);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.movie.title),
        actions: [
          Obx(() {
            return IconButton(
              icon: favoriteController.isFavorite(controller.movie)
                  ? Pulse(child: const Icon(Icons.favorite))
                  : Pulse(child: const Icon(Icons.favorite_border)),
              onPressed: () {
                favoriteController.addMovie(controller.movie);
              },
            );
          })
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      children: [
        Hero(
          tag: controller.movie.poster,
          child: Image.network(
            controller.movie.poster,
            height: context.heightTransformer(reducedBy: 25),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.movie.title,
                style: context.textTheme.headline5,
              ),
              const SizedBox(height: 10),
              Text(
                controller.movie.description,
                style: context.textTheme.bodyText1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    controller.movie.average.toString(),
                    style: context.textTheme.bodyText1,
                  ),
                  const SizedBox(width: 10),
                  FadeInRightBig(
                    child: AppRating(value: controller.movie.average),
                  ),
                ],
              ),
              Text(
                '${controller.movie.countAverage} Pessoas votaram',
                style: context.textTheme.bodyText1,
              ),
              Obx(credits),
              Text(
                'Filmes semelhantes',
                style: context.textTheme.headline6,
              ),
              Obx(similares),
            ],
          ),
        )
      ],
    );
  }

  Widget credits() {
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: const Text('Créditos'),
        children: List.generate(
          controller.credits.length,
          (index) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(controller.credits[index].name),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                controller.credits[index].picture,
              ),
            ),
            subtitle: Text(controller.credits[index].department),
          ),
        ),
      ),
    );
  }

  Widget similares() {
    return SizedBox(
      height: 350,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          controller.moviesSimilares.length,
          (index) => AppMovieCard(movie: controller.moviesSimilares[index]),
        ),
      ),
    );
  }
}
