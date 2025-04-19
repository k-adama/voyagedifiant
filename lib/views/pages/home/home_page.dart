import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/components/touristic_site.component.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/components/hotel_component.dart';
import 'package:voyagedifiant/views/pages/home/components/services_options.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/vehicule_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find();
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _pageTimer;
  final int _initialPage = 1000;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _initialPage, viewportFraction: 0.85);

    _pageTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (homeController.randomVehicles.isNotEmpty) {
        if (_currentPage < homeController.randomVehicles.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          shape: const Border(
            bottom: BorderSide.none,
          ),
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: AppColors.white,
        child: DrawerPageComponent(),
      ),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/basi.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Text(
                            "ENVIE D'UN SÉJOUR DE QUALITÉ SANS\n"
                            "SOUCIS DE DÉPLACEMENT ?\n"
                            "VOUS ÊTES À LA BONNE PORTE.",
                            textAlign: TextAlign.center,
                            style: AppColors.interBold(
                              size: 14,
                              color: AppColors.white,
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 80,
                        color: AppColors.primaryColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(90),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 0.1,
                              spreadRadius: 0.1,
                              offset: const Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 70),
                            Text(
                              'Louez un vehicule avec chauffeur',
                              style: AppColors.interBold(
                                size: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (homeController.isVehicleLoading ||
                                !homeController.hasConnection)
                              const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.red),
                              )
                            else if (homeController.vehicles.isEmpty)
                              const Center(
                                  child: Text("Aucun véhicule disponible"))
                            else if (homeController.randomVehicles.isEmpty)
                              const Center(
                                  child: Text("Aucun véhicule sélectionné"))
                            else
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: PageView.builder(
                                  itemCount:
                                      homeController.randomVehicles.length,
                                  controller: _pageController,
                                  itemBuilder: (context, index) {
                                    final vehicle =
                                        homeController.randomVehicles[index];
                                    return VehiculeCard(
                                      name: vehicle.name,
                                      price: vehicle.economyPrice.toString(),
                                      person: vehicle.numberOfSeats.toString(),
                                      bag: vehicle.luggage.toString(),
                                      image: vehicle.imageUrl,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.VEHICULE_DETAILS,
                                          arguments: vehicle,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            /*VehiculeCard(
                                name: homeController.randomVehicle.value!.name,
                                price: '3000'
                                    .toString(),
                                person: homeController
                                    .randomVehicle.value!.numberOfSeats
                                    .toString(),
                                bag: homeController.randomVehicle.value!.luggage
                                    .toString(),
                                image: homeController
                                    .randomVehicle.value!.imageUrl,
                                onTap: () {
                                  Get.toNamed(Routes.VEHICULE_DETAILS,
                                      arguments:
                                          homeController.randomVehicle.value);
                                },
                              ),*/

                            /* homeController.isVehicleLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ))
                                : Text("wooooooooo"),*/
                            /* VehiculeCard(
                                name: 'HUNDAI',
                                price: '35000',
                                person: '04',
                                bag: '01',
                                image: 'assets/images/Rectangle 11.png',
                                onTap: () {
                                  Get.toNamed(Routes.VEHICULE_ITEM_PAGE);
                                },
                              ),*/
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Envie de site touristique',
                              style: AppColors.interBold(
                                size: 14,
                              ),
                            ),
                            TouristSiteItemsComponents(
                              sites: homeController.randomTouristicSites,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Envie de séjourner',
                              style: AppColors.interBold(
                                size: 14,
                              ),
                            ),
                            const HotelComponents(
                              image: 'assets/images/sofi.png',
                              name: 'Sofitel hôtel Ivoire',
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: ServicesOptions(),
              ),
            ],
          ),
        );
      }),

      /* SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLoginRegisterHeader(
                    isLogo: false,
                    isNotHome: false,
                    isLogin: false,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Louez un vehicule avec chauffeur',
                          style: AppColors.interBold(
                            size: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        VehiculeCard(
                          name: 'HUNDAI',
                          price: '35000',
                          person: '04',
                          bag: '01',
                          image: 'assets/images/Rectangle 11.png',
                          onTap: () {
                            Get.toNamed(Routes.VEHICULE_ITEM_PAGE);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Envie de site touristique',
                          style: AppColors.interBold(
                            size: 14,
                          ),
                        ),
                        const HotelTouristSiteItemsComponents(
                          image: 'assets/images/cascade.png',
                          name: 'Cascade de Man',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Envie de séjourner',
                          style: AppColors.interBold(
                            size: 14,
                          ),
                        ),
                        const HotelTouristSiteItemsComponents(
                          image: 'assets/images/sofi.png',
                          name: 'Sofitel hôtel Ivoire',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Positioned(
                top: 140, // Rapprocher les containers du haut
                left: 0,
                right: 0,
                child: ServicesOptions(),
              ),
            ],
          ),
        ],
      )),*/
    );
  }
}