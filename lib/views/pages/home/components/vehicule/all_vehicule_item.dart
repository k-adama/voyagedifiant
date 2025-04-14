import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/publicity_container.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/vehicule_card.dart';

class AllVehiculeItems extends StatefulWidget {
  const AllVehiculeItems({super.key});

  @override
  State<AllVehiculeItems> createState() => _AllVehiculeItemsState();
}

class _AllVehiculeItemsState extends State<AllVehiculeItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarComponent(),
        ),
        endDrawer: const Drawer(
          backgroundColor: AppColors.white,
          child: DrawerPageComponent(),
        ),
        body: GetBuilder<HomeController>(
          builder: (ctrl) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels >=
                        scrollNotification.metrics.maxScrollExtent - 100 &&
                    !ctrl.isLoadingMore &&
                    ctrl.displayedVehicles.length < ctrl.vehicles.length) {
                  ctrl.loadMore();
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    children: [
                      const SearchBarComponent(
                        text: "Rechercher un véhicule",
                      ),
                      const PublicityContainer(
                        name:
                            'Nous mettons des chauffeurs et Vehicules de qualité à votre disposition',
                        background:
                            'assets/icons/undraw_electric_car_b-7-hl 1(1).png',
                      ),
                      if (ctrl.isVehicleLoading || !ctrl.hasConnection)
                        const Center(
                          child: CircularProgressIndicator(color: AppColors.signUpColor,),
                        )
                      else
                        AutoHeightGridView(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          mainAxisSpacing: 1,
                          itemCount: ctrl.displayedVehicles.length,
                          builder: (context, index) {
                            final vehicle = ctrl.displayedVehicles[index];
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 4,
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                    child: VehiculeCard(
                                  name: vehicle.name,
                                  price: '35000',
                                  person: vehicle.numberOfSeats.toString(),
                                  bag: vehicle.luggage.toString(),
                                  image: "assets/images/Rectangle 11.png",
                                  onTap: () {
                                    Get.toNamed(Routes.VEHICULE_DETAILS,
                                        arguments: vehicle);
                                  },
                                )),
                              ),
                            );
                          },
                        ),
                      if (ctrl.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CircularProgressIndicator(
                            color: AppColors.signUpColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
