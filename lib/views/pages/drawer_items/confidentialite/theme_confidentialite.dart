import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class ThemeConfidentialitePage extends StatefulWidget {
  const ThemeConfidentialitePage({super.key});

  @override
  State<ThemeConfidentialitePage> createState() =>
      _ThemeConfidentialitePageState();
}

class _ThemeConfidentialitePageState extends State<ThemeConfidentialitePage> {
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
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              Text("TERME ET CONFIDENTIALITE",
                  style: AppColors.interBold(
                    size: 18,
                    color: AppColors.primaryColor,
                  )),
              SizedBox(
                height: 30,
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        )));
  }
}
