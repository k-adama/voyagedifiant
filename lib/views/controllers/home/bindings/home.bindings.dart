import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
