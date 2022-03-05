import 'package:get/route_manager.dart';
import 'package:movie_app/modules/top_rated/top_rated_bindings.dart';
import 'package:movie_app/modules/top_rated/top_rated_page.dart';

class AppRouters {
  final pages = <GetPage>[
    GetPage(
      name: TOP_RATED,
      binding: TopRatedBindings(),
      page: () => const TopRatedPage(),
    )
  ];

  static const TOP_RATED = "/";
}
