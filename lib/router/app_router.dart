import 'package:get/route_manager.dart';
import 'package:movie_app/modules/favorites/favorites_bindings.dart';
import 'package:movie_app/modules/favorites/favorites_page.dart';
import 'package:movie_app/modules/movie_detail/movie_detail_bindings.dart';
import 'package:movie_app/modules/movie_detail/movie_detail_page.dart';
import 'package:movie_app/modules/movies_by_genre/movies_by_genre_bindings.dart';
import 'package:movie_app/modules/movies_by_genre/movies_by_genre_page.dart';
import 'package:movie_app/modules/search_movies/search_movies_bindings.dart';
import 'package:movie_app/modules/search_movies/search_movies_page.dart';
import 'package:movie_app/modules/top_rated/top_rated_bindings.dart';
import 'package:movie_app/modules/top_rated/top_rated_page.dart';
import 'package:movie_app/modules/video/video_bindings.dart';
import 'package:movie_app/modules/video/video_page.dart';

class AppRouters {
  final pages = <GetPage>[
    GetPage(
      name: TOP_RATED,
      binding: TopRatedBindings(),
      page: () => const TopRatedPage(),
    ),
    GetPage(
      name: MOVIE_DETAIL,
      binding: MovieDetailBindings(),
      page: () => const MovieDetailPage(),
    ),
    GetPage(
      name: SEARCH_MOVIES,
      binding: SearchMoviesBindings(),
      page: () => const SearchMoviesPage(),
    ),
    GetPage(
      name: MOVIES_BY_GENRES,
      binding: MoviesByGenreBindings(),
      page: () => const MoviesByGenrePage(),
    ),
    GetPage(
      name: MOVIES_FAVORITES,
      binding: FavoritesBindings(),
      page: () => const FavoritesPage(),
    ),
    GetPage(
      name: DETAIL_VIDEO,
      binding: VideoBindings(),
      page: () => const VideoPage(),
    ),
  ];

  static const TOP_RATED = "/";
  static const DETAIL_VIDEO = "/detail/video";
  static const MOVIE_DETAIL = "/detail";
  static const SEARCH_MOVIES = "/search";
  static const MOVIES_BY_GENRES = "/movies-by-genres";
  static const MOVIES_FAVORITES = "/favorites";
}
