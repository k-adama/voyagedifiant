import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

class DecouverteCardComponent extends StatelessWidget {
  const DecouverteCardComponent({
    super.key,
    this.image,
    required this.name,
    required this.price,
    this.color,
    required this.onTap,
    this.description,
    required this.depart,
    required this.arrived,
  });

  final String? image;
  final String name;
  final String? description;
  final String price;
  final Color? color;
  final String depart;
  final String arrived;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(10),
      //padding: const EdgeInsets.all(AppDefaults.padding),
      /* decoration: BoxDecoration(
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
            offset: const Offset(0, 2),
          ),
        ],
      ),*/
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 2,
            color: AppColors.cardColor,
          )),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: color ?? AppColors.transparent,
                      borderRadius: AppDefaults.borderRadius,
                      image: DecorationImage(
                        image: AssetImage(
                          image ?? 'assets/icons/hotpalm.png',
                        ),
                        // opacity: 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: AppColors.interBold(
                          size: 12,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    RatingBar.builder(
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/tabler_clock-hour-3.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('$depart - $arrived',
                            style: AppColors.interBold(
                              size: 12,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text('visite guidée à partir de $price',
                        style: AppColors.interBold(
                          size: 11,
                        )),
                  ],
                ),
              ),
            ),
            /* Expanded(
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
                          size: 12,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(description ?? '',
                        style: AppColors.interBold(
                          size: 12,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    FractionallySizedBox(
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/icons/person_place.png'),
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
            ),*/
          ],
        ),
      ),
    );
  }
}
