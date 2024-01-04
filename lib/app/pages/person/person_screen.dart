import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/components/movie_list.dart';
import 'package:movies_trailler_apps/app/pages/person/controller/person_controller.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';

class PersonScreen extends GetView<PersonController> {
  const PersonScreen({super.key});

  final String routes = "/PERSON_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return GetBuilder<PersonController>(
        init: PersonController(),
        builder: (controller) => SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      height: maxHeight,
                      width: maxWidth,
                      color: ColorConstant.colorBackground,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: maxHeight * 0.07),
                            // Background Person
                            _backgroundPerson(maxWidth),
                            const SizedBox(height: 32),
                            _namePlacePerson(),
                            const SizedBox(height: 25),
                            _infoPerson(),
                            const SizedBox(height: 32),
                            _biographyPerson(),
                            const SizedBox(height: 32),
                            MovieList(
                              title: "Movies",
                              size: size,
                              items: controller.listPersonMovie,
                              isHideSeeAll: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MenuAppbar(controller: controller)
                  ],
                ),
              ),
            ));
  }

  _biographyPerson() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Biography",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              "${controller.personDetail["biography"]}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  _infoPerson() {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[700],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                const Text(
                  "Gender",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(controller.personDetail["gender"] == 1 ? "Female" : "Male",
                    style: const TextStyle(
                      color: ColorConstant.colorTitleOnBackground,
                      fontWeight: FontWeight.w700,
                    ))
              ]))),
          VerticalDivider(
            thickness: 2,
            width: 2,
            indent: 15,
            endIndent: 15,
            color: Colors.grey[400],
          ),
          Expanded(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                const Text(
                  "Birthday",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(controller.personDetail["birthday"] ?? '',
                    style: const TextStyle(
                      color: ColorConstant.colorTitleOnBackground,
                      fontWeight: FontWeight.w700,
                    ))
              ]))),
          VerticalDivider(
            thickness: 2,
            width: 2,
            indent: 15,
            endIndent: 15,
            color: Colors.grey[400],
          ),
          Expanded(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                const Text(
                  "Known for",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(controller.personDetail["known_for_department"] ?? "",
                    style: const TextStyle(
                      color: ColorConstant.colorTitleOnBackground,
                      fontWeight: FontWeight.w700,
                    ))
              ]))),
          VerticalDivider(
            thickness: 2,
            width: 2,
            indent: 15,
            endIndent: 15,
            color: Colors.grey[400],
          ),
          Expanded(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                const Text(
                  "Popularity",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text("${controller.personDetail["popularity"]}%",
                    style: const TextStyle(
                      color: ColorConstant.colorTitleOnBackground,
                      fontWeight: FontWeight.w700,
                    ))
              ]))),
        ],
      ),
    );
  }

  _backgroundPerson(double maxWidth) {
    return Obx(() {
      String url = controller.personDetail["profile_path"] != null
          ? "${ApiMovies.image500}${controller.personDetail["profile_path"]}"
          : ApiMovies.fallbackPersonImage;
      return SizedBox(
        height: maxWidth * 0.67,
        width: maxWidth * 0.67,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            url,
          ),
        ),
      );
    });
  }

  _namePlacePerson() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${controller.personDetail["name"]}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${controller.personDetail["place_of_birth"]}",
          style: const TextStyle(
            color: ColorConstant.colorTitleOnBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class MenuAppbar extends StatelessWidget {
  const MenuAppbar({super.key, required this.controller});
  final PersonController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: ColorConstant.colorTitle,
                  borderRadius: BorderRadius.circular(10)),
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => controller.onChangeStatusFavourite(),
            icon: Icon(
              CupertinoIcons.heart_fill,
              color: controller.isFavourite.value
                  ? ColorConstant.colorTitle
                  : Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
