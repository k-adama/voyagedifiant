import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';

class MainController extends GetxController {
  var currentLocale = const Locale('fr', 'FR').obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? savedLang = LocalStorage.instance.getCurrentLanguage();
      if (savedLang != null && savedLang.isNotEmpty) {
        currentLocale.value = _localeFromCode(savedLang);
      } else {
        String deviceLangCode = Get.deviceLocale?.languageCode ?? 'fr';
        currentLocale.value =
            Locale(deviceLangCode, deviceLangCode.toUpperCase());
      }
      Get.updateLocale(currentLocale.value);
    });
  }

  void changeLanguage(String languageCode) async {
    currentLocale.value = _localeFromCode(languageCode);
    Get.updateLocale(currentLocale.value);
    await LocalStorage.instance.getLanguage(languageCode);
  }

  Locale _localeFromCode(String code) {
    if (code == 'en') {
      return const Locale('en', 'US');
    } else {
      return const Locale('fr', 'FR');
    }
  }
}
