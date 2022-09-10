import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/app_rating.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import 'package:movie_app/env.dart';
import 'package:movie_app/models/enums/country.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/modules/favorites/favorites_controller.dart';
import 'package:movie_app/router/app_router.dart';
import './movie_detail_controller.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

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
        elevation: 0,
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
          tag: controller.movie.hero,
          child: Container(
            constraints: const BoxConstraints(minHeight: 233),
            child: CachedNetworkImage(
              imageUrl: controller.movie.picture,
              width: double.infinity,
              placeholder: (context, url) {
                return const Center(child: CupertinoActivityIndicator());
              },
              errorWidget: (context, url, error) {
                return Image.asset(Env.LOGO);
              },
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      controller.movie.title,
                      style: context.textTheme.headline5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FlutterClipboard.copy(controller.movie.title);
                      Get.snackbar(
                          'Tudo pronto', 'O titulo do filme foi copiado',
                          backgroundColor: Colors.green,
                          snackPosition: Platform.isIOS
                              ? SnackPosition.BOTTOM
                              : SnackPosition.TOP,
                          colorText: Colors.white);
                    },
                    tooltip: "Copiar titulo",
                    icon: const Icon(Icons.copy),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SelectableText(
                controller.movie.description,
                style: context.textTheme.bodyText1,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ElevatedButton(
                    child: const Text("Assistir trailers"),
                    onPressed: () => Get.toNamed(
                      AppRouters.DETAIL_VIDEO,
                      arguments: controller.movie,
                    ),
                  ),
                ],
              ),
              Text(
                '${controller.movie.countAverage} Pessoas votaram',
                style: context.textTheme.bodyText1,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Obx(
                () => Wrap(
                  runAlignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Row(children: [
                      const Text('Onde Assistir:'),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 60,
                        child: DropdownButton<Countries>(
                          hint: Text(controller.country.value.name),
                          isExpanded: true,
                          items: Countries.values.map((e) {
                            return DropdownMenuItem(
                              child: Text(e.completeName),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (v) => controller.changeCountry(v),
                        ),
                      )
                    ]),
                    if ((controller.providers[controller.country.value] ?? [])
                        .isEmpty)
                      const Text("Nenhum provedor para esta região"),
                    ...(controller.providers[controller.country.value] ?? [])
                        .map((e) => Tooltip(
                              message: e.name,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CachedNetworkImage(imageUrl: e.logo),
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Filmes semelhantes',
                style: context.textTheme.headline6,
              ),
              const SizedBox(height: 5),
              Obx(similares),
              Obx(credits),
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
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          controller.moviesSimilares.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AppMovieCard(movie: controller.moviesSimilares[index]),
          ),
        ),
      ),
    );
  }
}
