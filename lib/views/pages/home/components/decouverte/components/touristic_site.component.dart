import 'package:flutter/material.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';

class TouristSiteItemsComponents extends StatelessWidget {
  final List<TouristicDiscovery> sites;
  final String? image;
  final String? name;
  const TouristSiteItemsComponents(
      {super.key, this.image, this.name, required this.sites});

  @override
  Widget build(BuildContext context) {
    if (sites.isEmpty) {
      return const Center(
        child: Text("Aucun site à afficher"),
      );
    }
    return AutoHeightGridView(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      itemCount: sites.take(3).length,
      builder: (context, index) {
        final site = sites[index];
        return AnimationConfiguration.staggeredGrid(
          columnCount: 4,
          position: index,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
            scale: 0.5,
            child: FadeInAnimation(
                child: InkWell(
              onTap: () {
                Get.toNamed(Routes.DECOUVERTE_DETAILS, arguments: site);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: AppDefaults.borderRadius,
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          image ?? 'assets/images/cascade.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      site.name ?? '',
                      style: AppColors.interBold(
                        size: 14,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
