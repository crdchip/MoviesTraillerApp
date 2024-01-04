import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/pages/movie/controller/movie_controller.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}
