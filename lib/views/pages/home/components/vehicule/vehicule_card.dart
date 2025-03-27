import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

class VehiculeCard extends StatelessWidget {
  const VehiculeCard({
    super.key,
    this.image,
    required this.name,
    required this.price,
    required this.person,
    required this.bag,
    this.color,
    required this.onTap,
  });

  final String? image;
  final String name;
  final String price;
  final String person;
  final String bag;
  final Color? color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 162,
          child: Container(
            margin: const EdgeInsets.all(10),
            //padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppDefaults.borderRadius,
              border: Border(
                left: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.2,
                ),
                right: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.2,
                ),
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.2,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: AppDefaults.borderRadius,
              child: InkWell(
                onTap: onTap,
                borderRadius: AppDefaults.borderRadius,
                child: Row(
                  children: [
                    /*  const SizedBox(
                      height: 160,
                      child:
                          DottedDivider(isVertical: true, color: Colors.white),
                    ),*/
                    Expanded(
                      flex: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(AppDefaults.padding),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color ?? AppColors.transparent,
                              borderRadius: AppDefaults.borderRadius,
                              image: DecorationImage(
                                image: AssetImage(
                                  image ?? 'assets/icons/location-icon.png',
                                ),
                                // opacity: 0.25,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: AppColors.interBold(
                                  size: 20,
                                )),
                            const SizedBox(
                              height: 12,
                            ),
                            FractionallySizedBox(
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          'assets/icons/person_place.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(person),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/bagage.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(bag),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text('A partir de $price',
                                style: AppColors.interNormal(
                                  size: 14,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
