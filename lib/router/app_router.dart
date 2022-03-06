import 'package:get/route_manager.dart';
import 'package:movie_app/modules/movie_detail/movie_detail_bindings.dart';
import 'package:movie_app/modules/movie_detail/movie_detail_page.dart';
import 'package:movie_app/modules/top_rated/top_rated_bindings.dart';
import 'package:movie_app/modules/top_rated/top_rated_page.dart';

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
  ];

  static const TOP_RATED = "/";
  static const MOVIE_DETAIL = "/detail";
}
