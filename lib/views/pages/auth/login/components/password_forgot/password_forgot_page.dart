import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class PasswordForgotPage extends StatefulWidget {
  const PasswordForgotPage({super.key});

  @override
  State<PasswordForgotPage> createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends State<PasswordForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();

  Future<void> sendOtpByEmail() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _authController.sendOtpToForgotPassword(_authController.email);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: GetBuilder<AuthController>(builder: (authController) {
          return Theme(
            data: AppTheme.defaultTheme.copyWith(
              inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
            ),
            child: LayoutBuilder(
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
                                    child: Image.asset(
                                        "assets/icons/logo-voyage.png"),
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
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'MOT DE PASSE OUBLIE',
                                        style: AppColors.interBold(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            AppDefaults.padding),
                                        child: Column(
                                          children: [
                                            Text(
                                              'S\'il vous plaît, entrez votre adresse e-mail pour pouvoir récupérer votre mot de passe',
                                              style: AppColors.interNormal(),
                                            ),
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Veuillez entrer votre adresse e-mail';
                                                      } else if (!RegExp(
                                                              r'^[^@]+@[^@]+\.[^@]+')
                                                          .hasMatch(value)) {
                                                        return 'Veuillez entrer une adresse e-mail valide';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    onChanged: (email) {
                                                      authController
                                                          .setEmail(email);
                                                    },
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Entrer votre E-mail',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  authController
                                                          .sendForgotLoading
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : AppCustomButton(
                                                          onPressed: () async {
                                                            await sendOtpByEmail();
                                                          },
                                                          buttonText:
                                                              "CONFIRMER",
                                                          textColor:
                                                              AppColors.white,
                                                          buttonColor: AppColors
                                                              .primaryColor,
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
                                'MOT DE PASSE OUBLIE',
                                style: AppColors.interBold(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppDefaults.padding),
                                child: Column(
                                  children: [
                                    Text(
                                      'S\'il vous plaît, entrez votre adresse e-mail pour pouvoir récupérer votre mot de passe',
                                      style: AppColors.interNormal(),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    TextFormField(
                                      validator:
                                          Validators.requiredWithFieldName('email')
                                              .call,
                                      //textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        labelText: 'Entrer votre E-mail',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    AppCustomButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.PASSWORD_FORGOT_OTP);
                                      },
                                      buttonText: "CONFIRMER",
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
                  ),*/
          );
        }));
  }
}
