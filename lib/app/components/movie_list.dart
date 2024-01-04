// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.title,
    required this.size,
    required this.items,
    required this.isHideSeeAll,
  });
  final String title;
  final Size size;
  final List<dynamic> items;
  final bool isHideSeeAll;

  @override
  Widget build(BuildContext context) {
    var height = size.height;
    var width = size.width;
    return Container(
      height: height * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                isHideSeeAll
                    ? const Text(
                        "See All",
                        style: TextStyle(
                          color: ColorConstant.colorTitle,
                          fontSize: 18,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (c, i) {
                String nameMovies = items[i]["title"].length > 14
                    ? items[i]["title"].substring(0, 10) + "..."
                    : items[i]["title"];
                String url = items[i]["poster_path"] != null
                    ? "${ApiMovies.image185}${items[i]["poster_path"]}"
                    : ApiMovies.fallbackMoviePoster;
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.movieScreen, arguments: items[i]["id"]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: height * 0.2,
                    width: width * 0.3,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.15,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          child: Text(
                            nameMovies,
                            style: const TextStyle(
                              color: ColorConstant.colorTitleOnBackground,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
