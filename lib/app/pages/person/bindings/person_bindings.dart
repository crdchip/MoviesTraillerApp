import 'package:get/get.dart';
import 'package:movies_trailler_apps/app/pages/person/controller/person_controller.dart';

class PersonBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonController>(() => PersonController());
  }
}
