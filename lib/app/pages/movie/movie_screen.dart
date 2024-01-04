import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/components/cast.dart';
import 'package:movies_trailler_apps/app/components/loading.dart';
import 'package:movies_trailler_apps/app/components/movie_list.dart';
import 'package:movies_trailler_apps/app/components/movies_list_trailler.dart';
import 'package:movies_trailler_apps/app/pages/movie/controller/movie_controller.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';

class MovieScreen extends GetView<MovieController> {
  const MovieScreen({super.key});

  final String routes = "/MOVIE_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return GetBuilder<MovieController>(
        init: MovieController(),
        builder: (controller) => WillPopScope(
              onWillPop: () async {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  body: Obx(
                    () {
                      return controller.isLoadPage.value == true
                          ? OrientationBuilder(
                              builder: (BuildContext context,
                                  Orientation orientation) {
                                return Container(
                                  height: maxHeight,
                                  width: maxWidth,
                                  color: ColorConstant.colorBackground,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            //Image
                                            Obx(() {
                                              String url = controller
                                                              .movieDetail[
                                                          "poster_path"] !=
                                                      null
                                                  ? "${ApiMovies.image500}${controller.movieDetail["poster_path"]}"
                                                  : ApiMovies
                                                      .fallbackMoviePoster;
                                              return Container(
                                                height: maxHeight * 0.55,
                                                width: maxWidth,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(url),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                height: maxHeight * 0.2,
                                                width: maxWidth,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment(0.5, 0),
                                                    end: Alignment(0.5, 1),
                                                    colors: [
                                                      Color.fromRGBO(
                                                          23, 23, 23, 0.8),
                                                      Color.fromRGBO(
                                                          23, 23, 23, 1),
                                                    ],
                                                    // stops: [4.0, 5.0],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .colorTitle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_outlined,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () => controller
                                                        .onChangeStatusFavourite(),
                                                    icon: Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: controller
                                                              .isFavourite.value
                                                          ? ColorConstant
                                                              .colorTitle
                                                          : Colors.white,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Movie Details
                                        Container(
                                          // height: maxHeight * 0.09,
                                          transform: Matrix4.translationValues(
                                              0.0, -150.0, 0.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Title
                                              Text(
                                                controller
                                                        .movieDetail["title"] ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              // Status, release year, runtime
                                              Text(
                                                "${controller.movieDetail["status"]} • ${controller.movieDetail["release_date"] != null ? controller.movieDetail["release_date"].split('-')[0] : ""} • ${controller.movieDetail["runtime"]} time",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: ColorConstant
                                                      .colorTitleOnBackground,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              // Genres
                                              SizedBox(
                                                width: maxWidth,
                                                height: 30,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: controller
                                                        .listGenres
                                                        .map((items) {
                                                      var showDot = items ==
                                                          controller.listGenres[
                                                              controller
                                                                      .listGenres
                                                                      .length -
                                                                  1];
                                                      return Text(
                                                        "$items ${showDot ? "" : "•"}",
                                                        style: const TextStyle(
                                                          color: ColorConstant
                                                              .colorTitleOnBackground,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      );
                                                    }).toList()),
                                              ),
                                              const SizedBox(height: 15),
                                              // Over View
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Text(
                                                  "${controller.movieDetail["overview"]}",
                                                  style: const TextStyle(
                                                    color: ColorConstant
                                                        .colorTitleOnBackground,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              const SizedBox(height: 32),
                                              MoviesListTrailler(
                                                title: "Trailler",
                                                size: size,
                                                items: controller
                                                    .listMovieTrailler,
                                              ),
                                              TopCast(
                                                size: size,
                                                items: controller.listTopCast,
                                              ),
                                              MovieList(
                                                title: "Simalar",
                                                size: size,
                                                items: controller
                                                    .listMoviesSimalar,
                                                isHideSeeAll: false,
                                              )
                                            ],
                                          ),
                                        )
                                        //
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Loading();
                    },
                  ),
                ),
              ),
            ));
  }
}
