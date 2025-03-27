import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/app_login_register_header.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: SafeArea(
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
      ),
    ));
  }
}
