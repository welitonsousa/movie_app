import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/router/app_router.dart';

import 'app_rating.dart';

class AppMovieCard extends StatefulWidget {
  final MovieModel movie;
  final double size;
  const AppMovieCard({Key? key, required this.movie, this.size = 140})
      : super(key: key);

  @override
  State<AppMovieCard> createState() => _AppMovieCardState();
}

class _AppMovieCardState extends State<AppMovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRouters.MOVIE_DETAIL,
        arguments: widget.movie,
        preventDuplicates: false,
      ),
      child: SizedBox(
        width: widget.size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: widget.movie.poster,
                child: CachedNetworkImage(
                  imageUrl: widget.movie.poster,
                  height: 210,
                  width: widget.size,
                  errorWidget: (c, s, d) => const Center(
                    child: Text(
                      "Não foi possível carregar esta imagem",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.size,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          widget.movie.average.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(width: 10),
                      AppRating(value: widget.movie.average)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
