import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';

import 'package:voyagedifiant/core/widgets/components/appbar/drawer_body_list_row.component.dart';

class DrawerPageBodyComponent extends StatelessWidget {
  const DrawerPageBodyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Historique",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
             Get.toNamed(Routes.HISTORIE_PAGE);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Modifier mon profil",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Modifier mon mot de passe",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Monnaie",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Questions fréquentes",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Termes et confidentialités",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
        ListTile(
          title: const DrawerBodyListRowComponent(
            name: "Nous contacter",
            emoji: "assets/icons/location-icon.png",
          ),
          onTap: () {
            // Get.toNamed(Routes.);
          },
        ),
      ],
    );
  }
}
