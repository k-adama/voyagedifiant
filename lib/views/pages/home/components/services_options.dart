import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/views/pages/home/components/custom_container_service.dart';

class ServicesOptions extends StatelessWidget {
  const ServicesOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomContainerService(
            imagePath: 'assets/icons/location-icon.png',
            title: 'Location',
            onTap: () {
              Get.toNamed(Routes.VEHICULE_ITEM_PAGE);
            },
          ),
          CustomContainerService(
            imagePath: 'assets/icons/decouverte-icon.png',
            title: 'decouverte',
            onTap: () {
              Get.toNamed(Routes.ALL_DECOUVERTE_ITEMS);
            },
          ),
          CustomContainerService(
            imagePath: 'assets/icons/sejour-icon.png',
            title: 'sejour',
            onTap: () {
              Get.toNamed(Routes.SEJOUR_ITEM_PAGE);
            },
          ),
        ],
      ),
    );
  }
}
