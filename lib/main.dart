import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movies_trailler_apps/app/pages/home/bindings/bindings.dart';
import 'package:movies_trailler_apps/app/pages/home/home_screens.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: HomeBindings(),
      initialRoute: Routes.homeScreen,
      getPages: AppPages.pages,
      home: const HomeScreens(),
    );
  }
}
