import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/route_manager.dart';

class MainController extends GetxController {
  var currentLocale = const Locale('fr', 'FR').obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String deviceLangCode = Get.deviceLocale?.languageCode ?? 'fr';
      currentLocale.value =
          Locale(deviceLangCode, deviceLangCode.toUpperCase());
      Get.updateLocale(currentLocale.value);
    });
  }

  void changeLanguage(String languageCode) {
    if (languageCode == 'fr') {
      currentLocale.value = const Locale('fr', 'FR');
    } else if (languageCode == 'en') {
      currentLocale.value = const Locale('en', 'US');
    }

    Get.updateLocale(currentLocale.value);
  }
}
