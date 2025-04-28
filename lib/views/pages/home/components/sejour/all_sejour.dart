import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/publicity_container.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/components/sejour_card.dart';

class AllSejourItems extends StatefulWidget {
  const AllSejourItems({super.key});

  @override
  State<AllSejourItems> createState() => _AllSejourItemsState();
}

class _AllSejourItemsState extends State<AllSejourItems> {
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
      body: GetBuilder<HomeController>(builder: (homeController) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent - 100 &&
                !homeController.isLoadingMoreHotels &&
                homeController.displayedHotels.length <
                    homeController.hotels.length) {
              homeController.loadMoreHotels();
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                   SearchBarComponent(
                    text: 'Rechercher un Motel',
                    onChanged: (text) {
                     homeController.searchQuery.value = text;
                    },
                  ),
                  const PublicityContainer(
                    name:
                        'Voulez-vous passer un séjour memorable? Vous êtes à la bonne porte',
                    background: 'assets/icons/Hotel Booking-rafiki 1.png',
                  ),
                  if (homeController.isHotelsLoading ||
                      !homeController.hasConnection)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.signUpColor,
                      ),
                    )
                  else if (homeController.hotels.isEmpty)
                    const Center(child: Text("Aucun hôtel disponible"))
                  else
                    AutoHeightGridView(
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      mainAxisSpacing: 2,
                      itemCount: homeController.displayedHotels.length,
                      builder: (context, index) {
                        final hotels = homeController.displayedHotels[index];
                          final currentLocale =
                                Get.locale?.languageCode ?? 'fr';
                            final description = currentLocale == 'en'
                                ? hotels.descriptionEn
                                : hotels.descriptionFr;
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: 4,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            scale: 0.5,
                            child: FadeInAnimation(
                                child: SejourCard(
                              name: hotels.name,
                              description: description,
                              price: hotels.priceStandard.toString(),
                              location: hotels.city,
                              //hasWifi: hotels.hasWifi.toString(),
                              //hasCleaning: hotels.hasCleaning.toString(),
                             // hasBreakfast: hotels.hasBreakfast.toString(),
                              onTap: () {
                                Get.toNamed(Routes.SEJOUR_DETAILS,
                                    arguments: hotels);
                              },
                            )),
                          ),
                        );
                      },
                    ),
                  if (homeController.isLoadingMoreHotels)
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
      }),
    );
  }
}
