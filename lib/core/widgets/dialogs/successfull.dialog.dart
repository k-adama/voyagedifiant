import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';

class SuccessfullDialog extends StatelessWidget {
  final String? title, content, buttonText, svgPicture, closeButton;
  final Function()? onPressed, closePressed, redirect;
  final bool haveButton, isCustomerAdded;

  const SuccessfullDialog({
    super.key,
    this.title,
    this.content,
    this.redirect,
    this.buttonText,
    this.svgPicture,
    required this.haveButton,
    this.closePressed,
    required this.isCustomerAdded,
    this.closeButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isRedirect = redirect != null;
    if (isRedirect) {
      Future.delayed(const Duration(seconds: 2), () {
        redirect?.call();
      });
    }
    return Container(
      width: 355.w,
      height: isRedirect ? 240.h : 311.h,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            30.verticalSpace,
            !isCustomerAdded
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: Text(
                        textAlign: TextAlign.center,
                        title ?? '',
                        style: AppColors.interBold(
                          size: 15.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: isRedirect ? 90.h : 68.h,
                    width: isRedirect ? 90.w : 68.w,
                    child: Center(
                      child: SvgPicture.asset(svgPicture!),
                    ),
                  ),
            isCustomerAdded
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: AppColors.interBold(
                          size: 15.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: isRedirect ? 90.h : 68.h,
                    width: isRedirect ? 90.w : 68.w,
                    child: Center(
                      child: SvgPicture.asset(svgPicture!),
                    ),
                  ),
            6.verticalSpace,
            SizedBox(
              width: 250,
              height: 50,
              child: Text(
                content ?? '',
                textAlign: TextAlign.center,
                style: AppColors.interBold(
                  size: 12.sp,
                  color: AppColors.black,
                ),
              ),
            ),
            50.verticalSpace,
            if (haveButton)
              AppCustomButton(
                buttonText: buttonText ?? "",
                textColor: AppColors.primaryColor,
                onPressed: onPressed ?? () => Navigator.pop(context),
              ),
            if (haveButton)
              AppCustomButton(
                buttonText: closeButton ?? "",
                textColor: AppColors.white,
                onPressed: closePressed ?? () => Navigator.pop(context),
              )
          ],
        ),
      ),
    );
  }
}
