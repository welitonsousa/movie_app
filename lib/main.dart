import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/bindings/app_binding.dart';
import 'package:movie_app/router/app_router.dart';

void main() {
  // Env.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      initialBinding: AppBindings(),
      getPages: AppRouters().pages,
    );
  }
}
