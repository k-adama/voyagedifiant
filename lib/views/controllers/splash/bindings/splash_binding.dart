import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}