import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/driver_cart_component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/travel_page_component.dart';

class MapsDatetimeCard extends StatefulWidget {
  const MapsDatetimeCard({super.key});

  @override
  State<MapsDatetimeCard> createState() => _MapsDatetimeCardState();
}

class _MapsDatetimeCardState extends State<MapsDatetimeCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: Colors.grey.withOpacity(0.8),
              width: 0.2,
            ),
            right: BorderSide(
              color: Colors.grey.withOpacity(0.8),
              width: 0.2,
            ),
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.8),
              width: 0.2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset('assets/images/maps.png'),
            const SizedBox(
              height: 10,
            ),
            const TravelPageComponent(),
            Container(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppDivider(),
                  Text(
                    "Période de location",
                    style: AppColors.interBold(
                      size: 12,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: AppColors.black),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(homeController.displayText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => homeController.selectDateRange(),
                        child: const Text('Modifier'),
                      ),
                    ],
                  ),
                  const AppDivider(),
                ],
              ),
            ),
            DriverCardComponent(
              driver: homeController.selectedChauffeur.value,
              onChange: () {
                AppHelpersCommon.showCustomModalBottomSheet(
                  context: context,
                  modal: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Choisir un autre chauffeur',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Liste des chauffeurs avec bouton "Choisir"
                        ...homeController.chauffeurs.map((chauffeur) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(chauffeur.imageUrl),
                            ),
                            title: Text(chauffeur.name),
                            subtitle: Text(chauffeur.phoneNumber),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () =>
                                  homeController.selectChauffeur(chauffeur),
                              child: const Text('Choisir'),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  isDarkMode: false,
                  isDrag: true,
                  radius: 12,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
