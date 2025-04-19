import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();
  Future<void> validNewPassword() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _authController.changePassword(
        _authController.email,
        _authController.password,
        _authController.confirmPassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          // leading: ,
        ),
        body: Theme(
          data: AppTheme.defaultTheme.copyWith(
            inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
          ),
          child: GetBuilder<AuthController>(builder: (authController) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
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
                                      color:
                                          AppColors.scaffoldWithBoxBackground,
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
                                                'Entrer votre nouveau mot de passe',
                                                style: AppColors.interNormal(),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              CustomField(
                                                onChanged: (password) {
                                                  authController
                                                      .setPassword(password);
                                                },
                                                label: const Text(
                                                    "Entrer nouveau mot de passe"),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.length < 8) {
                                                    return 'Le mot de passe doit contenir au moins 8 caractères';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CustomField(
                                                onChanged: (confirmPassword) {
                                                  authController
                                                      .setConfirmPassword(
                                                          confirmPassword);
                                                },
                                                label: const Text(
                                                    "Confirmer nouveau mot de passe"),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.length < 8) {
                                                    return 'Le mot de passe doit contenir au moins 8 caractères';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              authController
                                                      .isNewPasswordLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : AppCustomButton(
                                                      onPressed: () async {
                                                        await validNewPassword();
                                                      },
                                                      buttonText: "VALIDER",
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
                    ),
                  ),
                );
              },
            );
          }),
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
                                  'Entrer votre nouveau mot de passe',
                                  style: AppColors.interNormal(),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomField(
                                  label:
                                      const Text("Entrer nouveau mot de passe"),
                                  onFieldSubmitted: (v) => (),
                                  validator: Validators.password.call,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomField(
                                  label: const Text(
                                      "Confirmer nouveau mot de passe"),
                                  onFieldSubmitted: (v) => (),
                                  validator: Validators.password.call,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                AppCustomButton(
                                  onPressed: () {},
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
      ),*/
        ));
  }
}
