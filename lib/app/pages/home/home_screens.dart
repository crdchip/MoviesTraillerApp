import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movies_trailler_apps/app/components/movie_list.dart';
import 'package:movies_trailler_apps/app/components/trending_Movies.dart';
import 'package:movies_trailler_apps/app/pages/home/controller/home_controller.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

class HomeScreens extends GetView<HomeController> {
  const HomeScreens({super.key});
  final String routes = '/HOME_SCREENS';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstant.colorBackground,
            leading: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.menu_open_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
            title: RichText(
              text: const TextSpan(
                text: "M",
                style: TextStyle(
                  color: ColorConstant.colorTitle,
                  fontSize: 30,
                ),
                children: [
                  TextSpan(
                    text: "ovies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.searchScreen);
                },
                icon: const Icon(
                  CupertinoIcons.search,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Container(
            height: size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ColorConstant.colorBackground,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TrendingMovies(
                    size: size,
                    homeController: controller,
                  ),
                  MovieList(
                    title: "Upcoming",
                    size: size,
                    items: controller.listUpmingMovies,
                    isHideSeeAll: true,
                  ),
                  MovieList(
                    title: "TopRated",
                    size: size,
                    items: controller.listTopRatedMovies,
                    isHideSeeAll: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
