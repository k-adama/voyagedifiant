import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
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
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Entrez le code reçu',
                                  style: AppColors.interBold(),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                            border:
                                                Border.all(color: Colors.black),
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
