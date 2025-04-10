import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/icons/logo-voyage.png',
        height: 40,
      ),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      shape: const Border(
        bottom: BorderSide.none,
      ),
      // leading: ,
    );
  }
}
