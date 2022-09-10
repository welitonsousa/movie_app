import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/router/app_router.dart';

import 'app_rating.dart';

class AppMovieCard extends StatefulWidget {
  final MovieModel movie;
  final double size;
  const AppMovieCard({Key? key, required this.movie, this.size = 180})
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
                tag: widget.movie.hero,
                child: _image(widget.movie.poster),
              ),
            ),
            SizedBox(
              width: widget.size,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
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

  Widget _image(String url) {
    if (url.contains('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        height: 210,
        fit: BoxFit.cover,
        width: widget.size,
        placeholder: (context, url) {
          return const Center(child: CupertinoActivityIndicator());
        },
        errorWidget: (context, url, error) {
          return const Center(
              child: Text("Não foi possível exibir esta imagem"));
        },
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Image.asset(
        url,
        width: widget.size,
        height: 210,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
              child: Text("Não foi possível exibir esta imagem"));
        },
      ),
    );
  }
}
