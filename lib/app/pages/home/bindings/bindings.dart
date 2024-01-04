import 'package:get/instance_manager.dart';
import 'package:movies_trailler_apps/app/pages/home/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
