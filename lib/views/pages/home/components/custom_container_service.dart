import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class CustomContainerService extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function() onTap;
  const CustomContainerService({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin:
                const EdgeInsets.only(left: 16, top: 28, bottom: 28),
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    title.toUpperCase(),
                    style: AppColors.interBold(
                      size: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
