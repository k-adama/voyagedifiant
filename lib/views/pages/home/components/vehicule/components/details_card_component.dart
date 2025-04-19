import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class DetailsCardComponent extends StatefulWidget {
  const DetailsCardComponent({
    super.key,
    this.couponBackground,
    required this.name,
    required this.price,
    required this.businessPrice,
    required this.person,
    required this.bag,
    this.color,
    required this.airConditioning,
  });

  final String? couponBackground;
  final String name;
  final String price;
  final String businessPrice;
  final String person;
  final String bag;
  final String airConditioning;
  final Color? color;

  @override
  State<DetailsCardComponent> createState() => _DetailsCardComponentState();
}

class _DetailsCardComponentState extends State<DetailsCardComponent> {
  String? selectedClass;

  void selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      //padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
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
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gray,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Material(
                  color: AppColors.transparent,
                  borderRadius: AppDefaults.borderRadius,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: widget.color ?? AppColors.transparent,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child:
                                    Image.asset(widget.couponBackground ?? '')),
                          )),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: AppColors.signUpColor,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name,
                                    style: AppColors.interBold(
                                      size: 14,
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                FractionallySizedBox(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/person_place.png',
                                            color: AppColors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.person} passagers',
                                              style: AppColors.interNormal(
                                                color: AppColors.white,
                                                size: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/bagage.png',
                                            color: AppColors.white,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.bag} valise(s)',
                                              style: AppColors.interNormal(
                                                color: AppColors.white,
                                                size: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/nature_16239240 1.png',
                                            color: AppColors.white,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.airConditioning} climatisation',
                                              style: AppColors.interNormal(
                                                color: AppColors.white,
                                                size: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/siege.png',
                                            color: AppColors.white,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.bag} valise(s)',
                                              style: AppColors.interNormal(
                                                color: AppColors.white,
                                                size: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildClassButton('Economie', widget.price),
          const Divider(thickness: 2, color: AppColors.gray),
          _buildClassButton('Business', widget.businessPrice),
          const SizedBox(
            height: AppDefaults.padding,
          ),
        ],
      ),
    );
  }

  Widget _buildClassButton(String className, String price) {
    bool isSelected = selectedClass == className;
    return FractionallySizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('A partir de $price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedClass = isSelected ? null : className;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.signUpColor
                          : AppColors.primaryColor,
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Text(className,
                        style: const TextStyle(
                          color: AppColors.white,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (className == 'Economie')
              RatingBar.builder(
                initialRating: 3.5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                unratedColor: AppColors.primaryColor,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: AppColors.signUpColor),
                onRatingUpdate: (rating) {},
              ),
            if (className == 'Business')
              const Text('Chargeur à porter de main'),
          ],
        ),
      ),
    );
  }
}
