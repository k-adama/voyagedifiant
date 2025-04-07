import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
        Text('have_not_account'.tr),
        TextButton(
          onPressed: () {
            Get.offAllNamed(Routes.REGISTER_PAGE);
          },
          child: Text(
            'sign_up'.tr,
            style: const TextStyle(
              color: AppColors.signUpColor,
            ),
          ),
        ),
      ],
    );
  }
}
