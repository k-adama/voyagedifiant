import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

class PublicityContainer extends StatelessWidget {
  const PublicityContainer({
    super.key,
    this.background,
    required this.name,
    this.color,
  });

  final String? background;
  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 162,
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        //padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: AppDefaults.borderRadius,
         
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: AppDefaults.borderRadius,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: Text(
                          name,
                          style: AppColors.interBold(
                            size: 14,
                            color: AppColors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: AppDefaults.borderRadius,
                        image: DecorationImage(
                          image: AssetImage(
                            background ?? 'assets/icons/location-icon.png',
                          ),
                          // opacity: 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
