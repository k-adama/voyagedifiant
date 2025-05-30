import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_constants.dart';

class OrdersHistoryCard extends StatelessWidget {
  final String rentalPeriod;
  final String orderName;
  final String cout;
  final String driverName;
  final String rentalPeriodDays;
  const OrdersHistoryCard(
      {super.key,
      required this.rentalPeriod,
      required this.orderName,
      required this.cout,
      required this.driverName, required this.rentalPeriodDays});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 2,
            color: AppColors.cardColor,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset("assets/images/VoitureDetail.png"),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Date : ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppConstants.extractFormattedDateRange(
                                rentalPeriod),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: "Location de ",
                        style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: orderName,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text:
                                " pour ${AppConstants.calculateRentalDays(rentalPeriodDays)}",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text("Coût: ",
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                        Text("$cout FCFA",
                            style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text("Chauffeur: ",
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                        Text(driverName,
                            style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Lieu de prise en charge: ",
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                        Text(
                          "Yopougon, toit rouge",
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Lieu de restitution: ",
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                        Text(
                          "Angré, nouveau chu",
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
