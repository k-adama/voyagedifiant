import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/Main/controllers/main.controller.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => MainController());
  }
}
