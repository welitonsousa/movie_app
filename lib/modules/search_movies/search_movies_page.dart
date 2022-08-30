import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/widgets/movie_card.dart';
import './search_movies_controller.dart';

class SearchMoviesPage extends GetView<SearchMoviesController> {
  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: Get.back,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 3),
              child: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Pesquisar'),
                textInputAction: TextInputAction.done,
                onChanged: controller.onChange,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.width ~/ 140,
        mainAxisExtent: 265,
      ),
      itemCount: controller.movies.length,
      itemBuilder: (context, index) {
        controller.changeIndex(index);
        return Center(child: AppMovieCard(movie: controller.movies[index]));
      },
    );
  }
}
