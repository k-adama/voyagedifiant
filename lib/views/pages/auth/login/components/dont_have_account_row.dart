import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';

class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Vous n\'avez pas encore de compte ?'),
        TextButton(
          onPressed: () {
            Get.offAllNamed(Routes.REGISTER_PAGE);
          },
          child: const Text(
            'Inscrivez-vous',
            style: TextStyle(
              color: AppColors.signUpColor,
            ),
          ),
        ),
      ],
    );
  }
}
