import 'package:get/route_manager.dart';
import 'package:movies_trailler_apps/app/pages/home/home_screens.dart';
import 'package:movies_trailler_apps/app/pages/movie/movie_screen.dart';
import 'package:movies_trailler_apps/app/pages/person/person_screen.dart';
import 'package:movies_trailler_apps/app/pages/search/search_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreens(),
    ),
    GetPage(
      name: Routes.movieScreen,
      page: () => const MovieScreen(),
    ),
    GetPage(
      name: Routes.personScreen,
      page: () => const PersonScreen(),
    ),
    GetPage(
      name: Routes.searchScreen,
      page: () => const SearchScreen(),
    ),
  ];
}
