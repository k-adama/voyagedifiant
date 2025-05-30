import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/Main/controllers/main.controller.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut(() => MainController());
      Get.put(HomeController());
  }
}