import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_constants.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class OrdersHistoriePage extends StatefulWidget {
  const OrdersHistoriePage({super.key});

  @override
  State<OrdersHistoriePage> createState() => _OrdersHistoriePageState();
}

class _OrdersHistoriePageState extends State<OrdersHistoriePage> {
  HomeController homeController = Get.find();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeController.getVehiclesOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent -
                  200 && // déclenche 200px avant la fin
          !homeController.isVehicleOrdersLoading.value &&
          homeController.hasMore.value) {
        homeController.getVehiclesOrders();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              Obx(() {
                if (homeController.orders.isEmpty &&
                    homeController.isVehicleOrdersLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.signUpColor,
                  ));
                }

                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: homeController.hasMore.value
                        ? homeController.orders.length + 1
                        : homeController.orders.length,
                    itemBuilder: (context, index) {
                      if (index == homeController.orders.length) {
                        // Afficher un loader à la fin pendant le chargement
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.signUpColor,
                        ));
                      }

                      final order = homeController.orders[index];
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              AppConstants
                                                  .extractFormattedDateRange(
                                                      order.rentalPeriod),
                                              style: TextStyle(fontSize: 15),
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
                                              text: order.vehicleName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            TextSpan(
                                              text:
                                                  " pour ${AppConstants.calculateRentalDays(order.rentalPeriod)} jours",
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
                                          Text(
                                              "${order.totalPrice.toStringAsFixed(0)} FCFA",
                                              style: const TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text("Chauffeur: ",
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15)),
                                          Text(order.driverName,
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
                      /*  ListTile(
                        // leading: Image.network(order.vehicleImageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(order.vehicleName),
                        subtitle: Text(
                            "Chauffeur: ${order.driverName}\nPériode: ${order.rentalPeriod}"),
                        trailing:
                            Text("${order.totalPrice.toStringAsFixed(2)} €"),
                      );*/
                    },
                  ),
                );
              }),
              /*  Expanded(
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
              ),*/
            ],
          ),
        ));
  }
}
