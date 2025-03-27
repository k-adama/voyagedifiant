import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/app_login_register_header.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/pages/home/components/hotel_tourist_site/hotel_tourist_site_component.dart';
import 'package:voyagedifiant/views/pages/home/components/services_options.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/vehicule_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          leading: Image.asset(
            'assets/icons/logo-voyage.png',
          ),
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: AppColors.white,
        child: DrawerPageComponent(),
      ),
      body: SingleChildScrollView(
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
              Positioned(
                top: 140, // Rapprocher les containers du haut
                left: 0,
                right: 0,
                child: ServicesOptions(),
              ),
            ],
          ),
        ],
      )
          /*  Stack(
          children: [
            const AppLoginRegisterHeader(
              isLogo: false,
              isNotHome: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 220,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ServicesOptions(),
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
                                color: const Color(0xFF402FBE),
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Envi de site touristique',
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
                                color: const Color(0xFF402FBE),
                                onTap: () {},
                              ),
                               const SizedBox(
                                height: 8,
                              ),
                              VehiculeCard(
                                name: 'HUNDAI',
                                price: '35000',
                                person: '04',
                                bag: '01',
                                color: const Color(0xFF402FBE),
                                onTap: () {},
                              ),
                               const SizedBox(
                                height: 8,
                              ),
                              VehiculeCard(
                                name: 'HUNDAI',
                                price: '35000',
                                person: '04',
                                bag: '01',
                                color: const Color(0xFF402FBE),
                                onTap: () {},
                              ),
                               const SizedBox(
                                height: 8,
                              ),
                              VehiculeCard(
                                name: 'HUNDAI',
                                price: '35000',
                                person: '04',
                                bag: '01',
                                color: const Color(0xFF402FBE),
                                onTap: () {},
                              ),
                              //const HotelTouristSiteItemsComponents()
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),*/
          ),
    );
  }
}
