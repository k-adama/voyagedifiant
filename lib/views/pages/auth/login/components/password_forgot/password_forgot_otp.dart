import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class PasswordForgotPageOtp extends StatefulWidget {
  const PasswordForgotPageOtp({super.key});

  @override
  State<PasswordForgotPageOtp> createState() => _PasswordForgotPageOtpState();
}

class _PasswordForgotPageOtpState extends State<PasswordForgotPageOtp> {
  String enteredOtp = '';
  final AuthController _authController = Get.find();
  Color getBorderColor() {
    return _authController.checkOtp ? AppColors.signUpColor : AppColors.black;
  }

  bool isButtonDisabled = true;
  int countdown = 20;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (countdown == 0) {
        t.cancel();
        setState(() {
          isButtonDisabled = false;
        });
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void _restartCountdown() {
    setState(() {
      isButtonDisabled = true;
      countdown = 20;
    });
    _startCountdown();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.only(left: 10),
      width: 60,
      height: 60,
      textStyle: AppColors.interNormal(size: 22.sp, color: AppColors.black),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
        actions: const [
          TranslatePopItem(),
        ],
        // leading: ,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.3,
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.scaffoldWithBoxBackground,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            child: Center(
                              child:
                                  Image.asset("assets/icons/logo-voyage.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.primaryColor,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.scaffoldWithBoxBackground,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(97),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Entrez le code reçu',
                                  style: AppColors.interBold(),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(
                                    15.0,
                                  ),
                                  child: Text(
                                    'Veuillez saisir le code reçu par e-mail afin de réinitialiser votre mot de passe',
                                    style: AppColors.interNormal(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.all(AppDefaults.padding),
                                  child: Column(
                                    children: [
                                      Pinput(
                                        length: 4,
                                        onChanged: (value) {
                                          setState(() {
                                            enteredOtp = value;
                                          });
                                        },
                                        defaultPinTheme: PinTheme(
                                          width: 60,
                                          height: 60,
                                          textStyle: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.gray,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        focusedPinTheme:
                                            defaultPinTheme.copyWith(
                                          decoration: defaultPinTheme
                                              .decoration!
                                              .copyWith(
                                            border: Border.all(
                                                color: AppColors.signUpColor),
                                          ),
                                        ),
                                        onCompleted: (pin) async {
                                          await _authController
                                              .verifyOtpForgotPassword(
                                                  enteredOtp: enteredOtp);
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        "Vous n'avez pas reçu de code ?",
                                        style: AppColors.interNormal(),
                                      ),
                                      isButtonDisabled
                                          ? Text(
                                              "Réessayez dans ${countdown}s",
                                              style: AppColors.interNormal(
                                                  color: Colors.grey),
                                            )
                                          : TextButton(
                                              onPressed: () async {
                                                _restartCountdown();
                                                await _authController
                                                    .sendOtpToForgotPassword(
                                                  _authController.email,
                                                );
                                              },
                                              child: Text(
                                                'Réessayer',
                                                style: AppColors.interNormal(
                                                  color: AppColors.signUpColor,
                                                ),
                                              ),
                                            ),
                                      /* const SizedBox(
                                        height: 30,
                                      ),
                                      AppCustomButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.NEW_PASSWORD_PAGE);
                                        },
                                        buttonText: "VALIDER",
                                        textColor: AppColors.white,
                                        buttonColor: AppColors.primaryColor,
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      /* SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            const AppLoginRegisterHeader(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Entrez le code reçu',
                          style: AppColors.interBold(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppDefaults.padding),
                          child: Column(
                            children: [
                              Pinput(
                                length: 4,
                                onChanged: (value) {
                                  setState(() {
                                    enteredOtp = value;
                                  });
                                },
                                defaultPinTheme: PinTheme(
                                  width: 60,
                                  height: 60,
                                  textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    border: Border.all(
                                        color: AppColors.signUpColor),
                                  ),
                                ),
                                onCompleted: (pin) {
                                  // authController.otpEnters = pin;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AppCustomButton(
                                onPressed: () {
                                  Get.toNamed(Routes.NEW_PASSWORD_PAGE);
                                },
                                buttonText: "VALIDER",
                                textColor: AppColors.white,
                                buttonColor: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )*/
    );
  }
}
