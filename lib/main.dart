import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/bindings/app_binding.dart';
import 'package:movie_app/env.dart';
import 'package:movie_app/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF151C26),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF151C26)),
          scaffoldBackgroundColor: const Color(0xFF151C26),
          platform: TargetPlatform.iOS),
      debugShowCheckedModeBanner: Env.DEBUG_MODE,
      initialBinding: AppBindings(),
      getPages: AppRouters().pages,
    );
  }
}
