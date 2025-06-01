import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/login_form.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Supprime l'ombre
          actions: const [
            TranslatePopItem(
              isDrawer: true,
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Theme(
            data: AppTheme.defaultTheme.copyWith(
              inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
            ),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("MOT DE PASSE",
                          style: AppColors.interBold(
                            size: 18,
                            color: AppColors.primaryColor,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Entrez votre mot de passe actuel",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    CustomField(label: const Text("Entrez votre mot de passe")),
                    SizedBox(height: 35),
                    Text(
                      "Entrez votre nouveau mot de passe",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    CustomField(label: const Text("Entrez votre mot de passe")),
                    SizedBox(
                      height: 35,
                    ),
                    AppCustomButton(
                      onPressed: () async{},
                      buttonText: "Enregistrer",
                      textColor: AppColors.white,
                      buttonColor: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
            )))

        // Padding(
        // padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //    Text("Entrez votre mot de passe actuel", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 18),),
        //     CustomField(
        //     )
        //     ],
        //   ),
        // ),
        );
  }
}
