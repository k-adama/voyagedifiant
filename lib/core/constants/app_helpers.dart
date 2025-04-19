import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/auth.constant.dart';
import 'package:voyagedifiant/core/models/user.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';

class AppHelpersCommon {
  AppHelpersCommon._();

  static UserModel? getUserInLocalStorage() {
    final userEncoding =
         LocalStorage.instance.get(AuthConstant.keyUser);
    if (userEncoding == null) {
      logoutApi();
      return null;
    }

    final user = UserModel.fromJson(jsonDecode(userEncoding));
    return user;
  }

  static logoutApi() async {
    // final tajiriSdk = TajiriSDK.instance;
    try {
      Get.offAllNamed(Routes.LOGIN_PAGE);
      LocalStorage.instance.removeToken();
      LocalStorage.instance.removeBool("otp_verified");
      LocalStorage.instance.removeUserId("userId");
    } catch (e) {
      print('==> login failure: $e');
    }
  }

  static Future<dynamic> showCustomModalBottomSheet({
    required BuildContext context,
    required Widget modal,
    required bool isDarkMode,
    double radius = 16,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 200,
  }) {
    return showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: modal,
      ),
    );
  }

  // ALERT DIALOG

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
    bool isTransparent = false,
    Color backgroundColor = AppColors.white,
    bool canPop = true,
    double radius = 16,
  }) {
    AlertDialog alert = AlertDialog(
      backgroundColor: isTransparent ? AppColors.transparent : backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius.r),
        ),
      ),
      contentPadding: EdgeInsets.all(20.r),
      iconPadding: EdgeInsets.zero,
      content: PopScope(
        canPop: canPop,
        child: child,
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: canPop,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  /* static showCheckTopSnackBarInfo(BuildContext context, String text,
      {VoidCallback? onTap}) {
    return showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: text,
        ),
        onTap: onTap);
  }*/
}
