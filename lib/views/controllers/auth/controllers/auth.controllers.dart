import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/repositories/Auth/auth.repository.dart';
import 'package:voyagedifiant/core/services/app_connectivity.service.dart';

class AuthController extends GetxController {
  bool checkOtp = false;
  bool isLoading = false;
  String username = "";
  String email = "";
  String number = "";
  String city = "";
  String password = "";
  bool isLoginError = false;
  bool isNumberNotValid = false;
  bool isPasswordNotValid = false;

  final authRepository = AuthRepository();

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

  Future<void> onRegister() async {
    final connected = await AppConnectivityService.connectivity();
    if (username.isEmpty ||
        email.isEmpty ||
        city.isEmpty ||
        number.isEmpty ||
        password.isEmpty) {
      isLoginError = true;
      update();
      return;
    }
    if (!connected) {
      _showNoInternetPopup('Aucune connexion internet. Vérifiez votre réseau.');
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

      response.when(
        success: (data) async {
          // LocalStorage.instance.setToken(data?.token);
          //await getUser(context);
          print("compte créé");
           print(response);
          print("////////////////..........................");
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
