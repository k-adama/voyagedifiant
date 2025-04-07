import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
        Text('already_account'.tr),
        TextButton(
          onPressed: () {
            Get.offAllNamed(Routes.LOGIN_PAGE);
          },
          child: Text(
            'login_in_register'.tr,
            style: const TextStyle(
              color: AppColors.signUpColor,
            ),
          ),
        ),
      ],
    );
  }
}
