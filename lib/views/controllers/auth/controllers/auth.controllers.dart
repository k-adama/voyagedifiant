import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/auth.constant.dart';
import 'package:voyagedifiant/core/repositories/Auth/auth.repository.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/services/app_connectivity.service.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';

class AuthController extends GetxController {
  bool checkOtp = false;
  bool isLoading = false;
  String username = "";
  String email = "";
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var loginPhoneError = ''.obs;
  var passwordError = ''.obs;
  String number = "";
  String city = "";
  String password = "";
  bool isNumberNotValid = false;
  bool isPasswordNotValid = false;
  String tempToken = '';
  int? tempUserId;

  final authRepository = AuthRepository();

  Future<bool> sendOtpToEmail(String email) async {
    final response = await authRepository.sendOtp(
      email: email,
    );
    if (response.isSuccess()) {
      return true;
    } else {
      debugPrint(response.error.toString());
      return false;
    }
  }

  Future<bool> verifyOtp({required String enteredOtp}) async {
    final response = await authRepository.verifyOtp(
      email: email,
      otp: enteredOtp,
    );

    bool result = false;

    response.when(
      success: (_) {
        LocalStorage.instance.setToken(tempToken);
        LocalStorage.instance.setBool("otp_verified", true);
        LocalStorage.instance.setUserId(tempUserId ?? 0);
        result = true;
        Get.offAllNamed(Routes.HOME_PAGE);
        Get.snackbar("Bravo", 'Inscription réussie',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      },
      failure: (errorMessage) {
        Get.snackbar("Erreur", errorMessage,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        result = false;
      },
    );

    return result;
  }

  Future<void> onLogin() async {
    final connected = await AppConnectivityService.connectivity();
    if (number.isEmpty || password.isEmpty) {
      update();
      return;
    }
    if (!connected) {
      Get.snackbar(
          "Erreur", 'Aucune connexion internet. Vérifiez votre réseau.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      isLoading = true;
      update();
      final response = await authRepository.login(
        phone: number,
        password: password,
      );
      response.when(
        success: (data) async {
          LocalStorage.instance.setToken(data.token);
          LocalStorage.instance.setBool("otp_verified", true);
          LocalStorage.instance.setUserId(tempUserId ?? 0);
          await LocalStorage.instance.set(
            AuthConstant.keyUser,
            jsonEncode(data.toJson()),
          );
          Get.offAllNamed(Routes.HOME_PAGE);
          //await getUser(context);
        },
        failure: (errorMessage) {
          isLoading = false;
          if (errorMessage.contains("téléphone")) {
            loginPhoneError.value = "! Numéro incorrect.";
          } else if (errorMessage.contains("mot de passe")) {
            passwordError.value = "! Mot de passe incorrect.";
          }
          update();
        },
      );
    }
  }

  Future<bool> onRegister() async {
    final connected = await AppConnectivityService.connectivity();
    if (username.isEmpty ||
        email.isEmpty ||
        city.isEmpty ||
        number.isEmpty ||
        password.isEmpty) {
      update();
      return false; // ici aussi
    }

    if (!connected) {
      _showNoInternetPopup('Aucune connexion internet. Vérifiez votre réseau.');
      return false;
    } else {
      isLoading = true;
      update();

      final response = await authRepository.register(
        name: username,
        email: email,
        country: city,
        phone: number,
        password: password,
      );

      bool result = false;

      response.when(
        success: (data) async {
          tempToken = data.token ?? '';
          tempUserId = data.userId;
          print("compte créé avec token : ${data.token}");
          result = true;
          await sendOtpToEmail(email);
          isLoading = false;
          Get.toNamed(Routes.NUMBER_VERIFICATION_PAGE);
        },
        failure: (errorMessage) {
          isLoading = false;

          update();
          if (errorMessage.contains("email")) {
            emailError.value = "L'email est déjà pris.";
          }
          if (errorMessage.contains("phone")) {
            phoneError.value = "Le numéro est déjà utilisé.";
          } else {
            emailError.value = errorMessage;
          }
          //_showNoInternetPopup(errorMessage);
        },
      );

      return result;
    }
  }

  void _showNoInternetPopup(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 50, left: 10, right: 10),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void setPassword(String text) {
    password = text.trim();
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setNumber(String text) {
    number = text.replaceAll(RegExp(r'[^0-9]'), '');
    phoneError.value = '';
    loginPhoneError.value = '';
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setUsername(String text) {
    username = text.trim();
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setEmail(String text) {
    email = text.trim();
    emailError.value = '';
    isNumberNotValid = false;
    isPasswordNotValid = false;

    update();
  }

  void setCity(String text) {
    city = text.trim();
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }
}
