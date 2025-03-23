import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/publicity_container.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              const SearchBarComponent(),
              const PublicityContainer(
                name:
                    'Nous mettons des chauffeurs et Vehicules de qualité à votre disposition',
                background: 'assets/icons/undraw_electric_car_b-7-hl 1(1).png',
              ),
              AutoHeightGridView(
                shrinkWrap: true,
                crossAxisCount: 1,
                mainAxisSpacing: 2,
                itemCount: 5,
                builder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 4,
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      scale: 0.5,
                      child: FadeInAnimation(
                          child: VehiculeCard(
                        name: 'HUNDAI',
                        price: '35000',
                        person: '04',
                        bag: '01',
                        color: const Color(0xFF402FBE),
                        onTap: () {
                          Get.toNamed(Routes.VEHICULE_DETAILS);
                        },
                      )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
