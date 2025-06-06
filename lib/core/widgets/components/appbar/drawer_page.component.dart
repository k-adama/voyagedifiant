import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page_body.component.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page_header.component.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class DrawerPageComponent extends StatelessWidget {
  const DrawerPageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        actions: const [
          TranslatePopItem(
            isDrawer: true,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Center(child: DrawerPageHearderComponent())),
          const DrawerPageBodyComponent(),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: InkWell(
              onTap: () {
                _closeDrawerAndShowDialog(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.logout,
                    color: AppColors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Se déconnecter",
                      style: AppColors.interBold(
                        size: 15,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _closeDrawerAndShowDialog(BuildContext context) {
  Navigator.pop(context);

  Future.delayed(const Duration(milliseconds: 2), () {
    _showLogoutConfirmationDialog(context);
  });
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 5,
        shadowColor: AppColors.placeholder,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), 
        ),
        title: const Text(
          "ÊTES VOUS SÛR DE VOULOIR VOUS DECONNECTER ?",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "A quand votre retour vous nous manquer déjà",
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          Center(
            child: Column(
              children: [
                AppCustomButton(
                  onPressed: ()async {
                    LocalStorage.instance.removeToken();
                    LocalStorage.instance.removeBool("otp_verified");
                    LocalStorage.instance.removeUserId("userId");
                    Get.offAllNamed(Routes.LOGIN_PAGE);
                  },
                  buttonText: "SE DECONNECTER",
                  fontSize: 15,
                  textColor: AppColors.white,
                  buttonColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Ferme le popup
                  },
                  child: Text(
                    "ANNULER",
                    style: TextStyle(color: AppColors.signUpColor),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
