import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/Main/controllers/main.controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut(() => MainController());
  }
}