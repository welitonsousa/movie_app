import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/ui/widgets/app_rating.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/router/app_router.dart';

class AppMovieCard extends StatefulWidget {
  final MovieModel movie;
  const AppMovieCard({Key? key, required this.movie}) : super(key: key);

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
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
        width: context.widthTransformer(dividedBy: 2.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: widget.movie.poster,
                child: Image.network(widget.movie.poster, height: 250),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.movie.title,
              textAlign: TextAlign.left,
              maxLines: 1,
            ),
            Row(
              children: [
                Text(
                  widget.movie.average.toString(),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                AppRating(value: widget.movie.average)
              ],
            )
          ],
        ),
      ),
    );
  }
}
