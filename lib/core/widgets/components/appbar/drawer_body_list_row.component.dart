import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class DrawerBodyListRowComponent extends StatelessWidget {
  final String name;
  final String emoji;
  final bool isMonney;
  const DrawerBodyListRowComponent({
    super.key,
    required this.name,
    required this.emoji,
    this.isMonney = false,
  });

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
        Expanded(
          child: Text(
            name,
            style: AppColors.interBold(size: 15.sp),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        isMonney == true ? Text('XOF') : SizedBox.shrink()
      ],
    );
  }
}
