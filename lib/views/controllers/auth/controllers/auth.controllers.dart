import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/repositories/Auth/auth.repository.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/services/app_connectivity.service.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';

class AuthController extends GetxController {
  bool checkOtp = false;
  bool isLoading = false;
  String username = "";
  String email = "";
  String? emailError;
  String number = "";
  String city = "";
  String password = "";
  bool isLoginError = false;
  bool isNumberNotValid = false;
  bool isPasswordNotValid = false;

  final authRepository = AuthRepository();

  Future<bool> sendOtpToEmail(String email) async {
    final response = await authRepository.sendOtp(
      email: email,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.error.toString());
      return false;
    }
  }

   Future<bool> verifyOtp({required String enteredOtp}) async {
    final result = await authRepository.verifyOtp(
      email: email,
      otp: enteredOtp,
    );

    return result.statusCode == 200;
  }

  Future<void> onLogin() async {
    final connected = await AppConnectivityService.connectivity();
    if (number.isEmpty || password.isEmpty) {
      isLoginError = true;
      update();
      return;
    }
    if (!connected) {
      _showNoInternetPopup('Aucune connexion internet. Vérifiez votre réseau.');
    } else {
      isLoading = true;
      update();
      final response = await authRepository.login(
        phone: number,
        password: password,
      );
      response.when(
        success: (data) async {
          // LocalStorage.instance.setToken(data?.token);
          //await getUser(context);
          print("il est connecté");
          print(response);
          print("il est connecté ..........................");
        },
        failure: (failure, status) {
          isLoading = false;
          isLoginError = true;
          update();

          _showNoInternetPopup("Pas dans la bd");
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
      isLoginError = true;
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
          LocalStorage.instance.setToken(data?.token);
          print("compte créé avec token : ${data?.token}");
          result = true;
          await sendOtpToEmail(email);
          Get.toNamed(Routes.NUMBER_VERIFICATION_PAGE);
        },
        failure: (failure, status) {
          isLoading = false;
          isLoginError = true;
          update();
          _showNoInternetPopup("Pas dans la BD");
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
    isLoginError = false;
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setNumber(String text) {
    number = text.replaceAll(RegExp(r'[^0-9]'), '');
    isLoginError = false;
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setUsername(String text) {
    username = text.trim();
    isLoginError = false;
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }

  void setEmail(String text) {
    email = text.trim();
    isLoginError = false;
    isNumberNotValid = false;
    isPasswordNotValid = false;

    update();
  }

  void setCity(String text) {
    city = text.trim();
    isLoginError = false;
    isNumberNotValid = false;
    isPasswordNotValid = false;
    update();
  }
}
