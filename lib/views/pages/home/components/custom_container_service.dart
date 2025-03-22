import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

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
            margin: const EdgeInsets.all(AppDefaults.padding),
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: AppDefaults.boxShadow,
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
