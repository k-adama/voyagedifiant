import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:voyagedifiant/core/animation/images_rotations.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/core/widgets/hotel_history_card.dart';
import 'package:voyagedifiant/core/widgets/orders_history_card.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class OrdersHistoriePage extends StatefulWidget {
  const OrdersHistoriePage({super.key});

  @override
  State<OrdersHistoriePage> createState() => _OrdersHistoriePageState();
}

class _OrdersHistoriePageState extends State<OrdersHistoriePage> {
  HomeController homeController = Get.find();

  final ScrollController _scrollController = ScrollController();

  final RefreshController _controller = RefreshController();
  void _onRefresh() async {
    homeController.getAllOrders();
    _controller.refreshCompleted();
  }

  void _onLoading() async {
    homeController.getAllOrders();
    _controller.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    homeController.getAllOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !homeController.isVehicleOrdersLoading.value &&
          homeController.hasMore.value) {
        homeController.getAllOrders();
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
                  child: homeController.orders.isEmpty
                      ? const Center(
                          child: RotatingSvgImage(
                            assetPath: "assets/svgs/orders_empty.svg",
                            size: 250,
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: homeController.hasMore.value
                              ? homeController.orders.length + 1
                              : homeController.orders.length,
                          itemBuilder: (context, index) {
                            if (index == homeController.orders.length) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.signUpColor,
                              ));
                            }

                            final order = homeController.orders[index];
                            final List<Widget> cards = [];

                            if (order.vehicleDetails != null) {
                              final vehicle = order.vehicleDetails!;
                              cards.add(
                                OrdersHistoryCard(
                                  rentalPeriod: vehicle.rentalPeriod,
                                  orderName: vehicle.vehicleName,
                                  rentalPeriodDays: vehicle.rentalPeriod,
                                  cout: order.totalPrice,
                                  driverName: vehicle.driverName,
                                ),
                              );
                            }
                            if (order.hotelDetails != null) {
                              final hotel = order.hotelDetails!;
                              cards.add(
                                HotelsHistoryCard(
                                  rentalPeriod: hotel.reservationPeriod,
                                  orderName: hotel.hotelName,
                                  rentalPeriodDays: hotel.reservationPeriod,
                                  cout: order.totalPrice,
                                  driverName: hotel.driverName,
                                ),
                              );
                            }
                            if (order.discoveryDetails != null) {
                              final discovery = order.discoveryDetails!;
                              cards.add(
                                OrdersHistoryCard(
                                  rentalPeriod: discovery.reservationPeriod,
                                  orderName: discovery.siteName,
                                  rentalPeriodDays: discovery.reservationPeriod,
                                  cout: order.totalPrice,
                                  isDriver: false,
                                  isLocationText: false,
                                ),
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: cards,
                            );

                            /* Card(
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
                                                  order.vehicleDetails!
                                                      .rentalPeriod),
                                          style:
                                              const TextStyle(fontSize: 15),
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
                                          text: order
                                              .vehicleDetails!.vehicleName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text:
                                              " pour ${AppConstants.calculateRentalDays(order.vehicleDetails!.rentalPeriod)}",
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
                                          "${order.vehicleDetails!.totalPrice.toStringAsFixed(0)} FCFA",
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
                                      Text(order.vehicleDetails!.driverName,
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
                  );*/
                          },
                        ),
                );
              }),
            ],
          ),
        ));
  }
}
