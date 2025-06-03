import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  HomeController homeController = Get.find();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

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
                    const Text(
                      "Entrez votre mot de passe actuel",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    CustomField(
                        controller: oldPasswordController,
                        label: const Text("Entrez votre mot de passe")),
                    const SizedBox(height: 35),
                    const Text(
                      "Entrez votre nouveau mot de passe",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    CustomField(
                        controller: newPasswordController,
                        label: const Text("Entrez votre mot de passe")),
                    const SizedBox(
                      height: 35,
                    ),
                    Obx(() => AppCustomButton(
                          onPressed:
                              homeController.isPaaswordChangeLoading.value
                                  ? null
                                  : () async {
                                      homeController.changePassword(
                                          context,
                                          oldPasswordController.text,
                                          newPasswordController.text);
                                    },
                          buttonText:
                              homeController.isPaaswordChangeLoading.value
                                  ? "Modification en cours..."
                                  : "Enregistrer",
                          textColor: AppColors.white,
                          buttonColor: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        )),
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
