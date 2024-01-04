import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_trailler_apps/config/constants/api_movies.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';
import 'package:movies_trailler_apps/config/routes/pages.dart';

class TopCast extends StatelessWidget {
  const TopCast({super.key, required this.size, required this.items});
  final Size size;
  final List items;

  @override
  Widget build(BuildContext context) {
    double maxHeight = size.height;
    double maxWidth = size.width;
    return Container(
        margin: const EdgeInsets.only(left: 16),
        width: maxWidth,
        height: maxHeight * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Cast",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.personScreen,
                            arguments: items[i]["id"]);
                      },
                      child: TopCastCard(
                        items: items[i],
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}

class TopCastCard extends StatelessWidget {
  const TopCastCard({super.key, required this.items});
  final Map<String, dynamic> items;

  @override
  Widget build(BuildContext context) {
    String urlImage = items["profile_path"] != null
        ? "${ApiMovies.image185}${items["profile_path"]}"
        : ApiMovies.fallbackPersonImage;
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  urlImage,
                ),
              )),
          Text(
            "${items["character"].length > 10 ? items["character"].substring(0, 10) : items["character"]}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "${items["original_name"].length > 10 ? items["original_name"].substring(0, 10) : items["original_name"]}",
            style: const TextStyle(
              color: ColorConstant.colorTitleOnBackground,
            ),
          ),
        ],
      ),
    );
  }
}
