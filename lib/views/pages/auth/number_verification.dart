import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:pinput/pinput.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class NumberVerificationPage extends StatefulWidget {
  const NumberVerificationPage({super.key});

  @override
  State<NumberVerificationPage> createState() => _NumberVerificationPageState();
}

class _NumberVerificationPageState extends State<NumberVerificationPage> {
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
        shape: const Border(
          bottom: BorderSide.none,
        ),
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
                                horizontal: 20, vertical: 30),
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
                                    'Veuillez saisir le code reçu par e-mail afin de terminer votre inscription',
                                    style: AppColors.interNormal(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                          color: AppColors.gray, width: 1),
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
                                  onCompleted: (pin) async {
                                    bool isOtpValid = await _authController
                                        .verifyOtp(enteredOtp: enteredOtp);
                                    if (isOtpValid) {
                                      TopSnackbar.show(
                                        context,
                                        message: "OTP vérifié avec succès",
                                        backgroundColor: Colors
                                            .green, // Couleur de fond de succès
                                      );
                                    } else {
                                      // Afficher un message d'erreur avec TopSnackbar
                                      TopSnackbar.show(
                                        context,
                                        message: "OTP invalide",
                                        backgroundColor: Colors
                                            .red, // Couleur de fond d'erreur
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Vous n'avez pas reçu de code ?",
                                  style: AppColors.interNormal(),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      await _authController.sendOtpToEmail(
                                        _authController.email,
                                      );
                                      // Get.offAllNamed(Routes.HOME_PAGE);
                                    },
                                    child: Text(
                                      'Rééssayer',
                                      style: AppColors.interNormal(
                                        color: AppColors.signUpColor,
                                      ),
                                    ))
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
      /*SafeArea(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 290,
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
                            Padding(
                              padding: const EdgeInsets.all(
                                15.0,
                              ),
                              child: Text(
                                'Veuillez saisir le code reçu par e-mail afin de terminer votre inscription',
                                style: AppColors.interNormal(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            /*  const SizedBox(
                              height: 30,
                            ),
                            FractionallySizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Votre numéro"),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: AppColors.signUpColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Modifier",
                                          style: TextStyle(
                                            color: AppColors.signUpColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const FractionallySizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '010101010',
                                    style: TextStyle(
                                      color: AppColors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),*/

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
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  border:
                                      Border.all(color: AppColors.signUpColor),
                                ),
                              ),
                              onCompleted: (pin) {
                                // authController.otpEnters = pin;
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "Vous n'avez pas reçu de code ?",
                              style: AppColors.interNormal(),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.offAllNamed(Routes.HOME_PAGE);
                                },
                                child: Text(
                                  'Rééssayer',
                                  style: AppColors.interNormal(
                                    color: AppColors.signUpColor,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}

class TopSnackbar {
  static void show(BuildContext context,
      {required String message, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
