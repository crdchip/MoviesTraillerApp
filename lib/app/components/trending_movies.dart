// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/pages/home/controller/home_controller.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies(
      {super.key, required this.size, required this.homeController});
  final Size size;
  final HomeController? homeController;

  @override
  Widget build(BuildContext context) {
    var height = size.height;
    var width = size.width;
    return Container(
      height: height * 0.4,
      width: width,
      margin: const EdgeInsets.only(top: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: const Text(
              "TrendingMovies",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              height: height * 0.3,
              child: CarouselSlider(
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    height: height * 0.3,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    viewportFraction: 0.6,
                  ),
                  items: homeController!.listTrendingMovies
                      .map((i) => MovieCard(items: i, width: width))
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.items, required this.width});
  final Map<String, dynamic> items;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.movieScreen, arguments: items["id"]);
          },
          child: Container(
            width: width * 0.8,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: NetworkImage(
                  "${ApiMovies.image500}${items["poster_path"]}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
