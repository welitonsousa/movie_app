import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './top_rated_controller.dart';

class TopRatedPage extends GetView<TopRatedController> {
    
    const TopRatedPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('TopRatedPage'),),
            body: Container(),
        );
    }
}