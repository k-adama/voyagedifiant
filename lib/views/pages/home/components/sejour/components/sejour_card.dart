import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

class SejourCard extends StatelessWidget {
  const SejourCard({
    super.key,
    this.image,
    required this.name,
    required this.price,
    required this.location,
    this.color,
    required this.onTap,
    this.description,
    required this.hasCleaning,
    required this.hasWifi,
    required this.hasBreakfast,
  });

  final String? image;
  final String name;
  final String? description;
  final String price;
  final String location;
  final Color? color;
  final void Function() onTap;
  final String hasCleaning;
  final String hasWifi;
  final String hasBreakfast;

  @override
  Widget build(BuildContext context) {
    final visibleItemsCount = [
      hasCleaning,
      hasWifi,
      hasBreakfast,
    ].where((e) => e == "true").length;

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
          borderRadius: AppDefaults.borderRadius,
          side: const BorderSide(
            width: 2,
            color: AppColors.cardColor,
          )),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Container(
                    // width: 180,
                    height: 130,
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
                        style: AppColors.interNormal(
                          size: 12,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    FractionallySizedBox(
                        child: Row(
                      mainAxisAlignment: visibleItemsCount <= 1
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // ou start selon ton besoin
                      children: [
                        if (hasCleaning == "true")
                          Column(
                            children: [
                              Image.asset('assets/icons/menage.png'),
                              const SizedBox(height: 5),
                              const Text('ménage'),
                            ],
                          ),
                        if (hasWifi == "true")
                          Column(
                            children: [
                              Image.asset('assets/icons/wifi.png'),
                              const SizedBox(height: 5),
                              const Text('wifi'),
                            ],
                          ),
                        if (hasBreakfast == "true")
                          Column(
                            children: [
                              Image.asset('assets/icons/hamb.png'),
                              const SizedBox(height: 5),
                              const Text('petit déj'),
                            ],
                          ),
                      ],
                    )),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/location.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(location),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('A partir de $price',
                        style: AppColors.interBold(
                          size: 14,
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
