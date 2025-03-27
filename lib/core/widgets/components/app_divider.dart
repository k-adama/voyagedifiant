import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: AppColors.gray,
    );
  }
}
