import 'package:flutter/cupertino.dart';
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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(
            builder: (c, constrains) {
              return Obx(() => _body(c, constrains));
            },
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, BoxConstraints constraints) {
    if (controller.loading) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (controller.movies.isEmpty && controller.search.isNotEmpty) {
      return const Center(child: Text("Nenhum resultado encontrado"));
    } else if (controller.movies.isEmpty) {
      return const Center(child: Text("Comece a pesquisar"));
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth ~/ 140,
          mainAxisExtent: 265,
          crossAxisSpacing: 5,
        ),
        controller: controller.scroll,
        itemCount: controller.movies.length,
        itemBuilder: (context, index) {
          controller.changeIndex(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: AppMovieCard(movie: controller.movies[index]),
          );
        },
      ),
    );
  }
}
