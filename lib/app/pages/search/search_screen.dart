import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/pages/search/controller/search_controller.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

class SearchScreen extends GetView<SearchMoviesController> {
  const SearchScreen({super.key});

  final String routes = "/SEARCH_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = size.height;
    double maxWidth = size.width;
    return GetBuilder<SearchMoviesController>(
      init: SearchMoviesController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: Container(
            height: maxHeight,
            width: maxWidth,
            color: ColorConstant.colorBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchNavbar(),
                const SizedBox(height: 15),
                Expanded(
                  child: controller.listSearchMovies.isNotEmpty
                      ? _listSearchMovies()
                      : _listEmpty(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listSearchMovies() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Results(${controller.listSearchMovies.length})",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 4,
              crossAxisCount: 2, // Number Column
              crossAxisSpacing: 15.0, // Space ngang
              mainAxisSpacing: 20.0, // Space doc
            ),
            itemCount: controller.listSearchMovies.length,
            itemBuilder: (context, i) {
              String title = controller.listSearchMovies[i]["title"].length > 22
                  ? "${controller.listSearchMovies[i]["title"].substring(0, 22)}..."
                  : "${controller.listSearchMovies[i]["title"]}";
              String image = controller.listSearchMovies[i]["poster_path"] !=
                      null
                  ? "${ApiMovies.image185}${controller.listSearchMovies[i]["poster_path"]}"
                  : ApiMovies.fallbackMoviePoster;
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.movieScreen,
                    arguments: controller.listSearchMovies[i]["id"],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _listEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 384,
          width: 384,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/movieTime.png"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  _searchNavbar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: TextFormField(
        controller: controller.searchController,
        onChanged: (value) =>
            controller.fetchSearchMovies(keyMovies: {"query": value}),
        decoration: InputDecoration(
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {
                if (controller.searchController.text.isEmpty) {
                  Get.back();
                } else {
                  controller.searchController.text = "";
                }
              },
              icon: const Icon(
                Icons.close,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          hintText: "Search Movie",
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
