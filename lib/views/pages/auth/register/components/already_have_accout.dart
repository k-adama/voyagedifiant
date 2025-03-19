import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Dèjà un compte ?'),
        TextButton(
          onPressed: () {
            Get.offAllNamed(Routes.LOGIN_PAGE);
          },
          child: const Text(
            'Connectez-vous',
            style: TextStyle(
              color: AppColors.signUpColor,
            ),
          ),
        ),
      ],
    );
  }
}
