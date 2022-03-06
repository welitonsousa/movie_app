import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './search_movies_controller.dart';

class SearchMoviesPage extends GetView<SearchMoviesController> {
    
    const SearchMoviesPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('SearchMoviesPage'),),
            body: Container(),
        );
    }
}