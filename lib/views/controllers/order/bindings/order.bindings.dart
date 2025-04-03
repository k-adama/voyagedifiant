import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/views/controllers/order/controllers/order.controllers.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
