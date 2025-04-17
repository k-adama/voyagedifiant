import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_constants.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/publicity_container.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/components/decouverte_card.dart';

class AllDecouverteItems extends StatefulWidget {
  const AllDecouverteItems({super.key});

  @override
  State<AllDecouverteItems> createState() => _AllDecouverteItemsState();
}

class _AllDecouverteItemsState extends State<AllDecouverteItems> {
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
          builder: (homeController) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels >=
                        scrollNotification.metrics.maxScrollExtent - 100 &&
                    !homeController.isLoadingMoreTouristicSite &&
                    homeController.displayedTouristicSites.length <
                        homeController.touristicSites.length) {
                  homeController.loadMoreTouristicSites();
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    children: [
                      SearchBarComponent(
                        text: 'Rechercher un site',
                        onChanged: (text) {
                          homeController.hotelSearchFilter(text);
                        },
                      ),
                      const PublicityContainer(
                        name:
                            "Plongez dans une expérience unique au coeur de la Côte D'Ivoire",
                        background:
                            'assets/icons/People sightseeing outdoors-cuate 1.png',
                      ),
                      if (homeController.isTouristicSiteLoading ||
                          !homeController.hasConnection)
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.signUpColor,
                          ),
                        )
                      else if (homeController.touristicSites.isEmpty)
                        const Center(child: Text("Aucun véhicule disponible"))
                      else
                        AutoHeightGridView(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          mainAxisSpacing: 2,
                          itemCount:
                              homeController.displayedTouristicSites.length,
                          builder: (context, index) {
                            final touristicSites =
                                homeController.displayedTouristicSites[index];
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 4,
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                    child: DecouverteCardComponent(
                                  name: touristicSites.name,
                                  description: touristicSites.description,
                                  price:
                                      touristicSites.standardPrice.toString(),
                                  onTap: () {
                                    Get.toNamed(Routes.DECOUVERTE_DETAILS,
                                        arguments: touristicSites);
                                  },
                                  depart: AppConstants.formatTime(
                                      touristicSites.visitStartTime),
                                  arrived: AppConstants.formatTime(
                                      touristicSites.visitEndTime),
                                )),
                              ),
                            );
                          },
                        ),
                      if (homeController.isLoadingMoreTouristicSite)
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
