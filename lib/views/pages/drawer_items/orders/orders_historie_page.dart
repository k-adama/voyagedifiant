import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class OrdersHistoriePage extends StatefulWidget {
  const OrdersHistoriePage({super.key});

  @override
  State<OrdersHistoriePage> createState() => _OrdersHistoriePageState();
}

class _OrdersHistoriePageState extends State<OrdersHistoriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            TranslatePopItem(
              isDrawer: true,
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("HISTORIQUE DES COMMANDES",
                  style: AppColors.interBold(
                    size: 18,
                    color: AppColors.primaryColor,
                  )),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
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
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Date : ",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                        Text("04-11-2024 au 07-04-2024"),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Location de Hundrai pour 3jours",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Coût: ",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                        Text("210 000FCFA ",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Chauffeur: ",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                        Text("Koffi Laurent",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
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
                                    SizedBox(height: 8),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
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
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
