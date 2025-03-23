import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class DrawerBodyListRowComponent extends StatelessWidget {
  final String name;
  final String emoji;
  const DrawerBodyListRowComponent(
      {super.key, required this.name, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          emoji,
          height: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: AppColors.interBold(size: 15.sp),
        )
      ],
    );
  }
}
