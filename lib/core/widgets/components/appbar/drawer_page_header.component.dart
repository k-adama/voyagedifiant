import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class DrawerPageHearderComponent extends StatelessWidget {
  const DrawerPageHearderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = AppHelpersCommon.getUserInLocalStorage();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.signUpColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '🧔🏽‍',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "Chara",
            style: AppColors.interBold(color: AppColors.signUpColor, size: 15),
          ),
        ),
      ],
    );
  }
}
