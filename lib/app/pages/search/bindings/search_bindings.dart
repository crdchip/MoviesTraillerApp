import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/pages/search/controller/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMoviesController>(() => SearchMoviesController());
  }
}
