import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenue',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
    );
  }
}
