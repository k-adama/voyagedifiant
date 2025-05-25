import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider.dart';
import 'package:voyagedifiant/core/widgets/components/sejour_decouverte_travel.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/driver_cart_component.dart';

class SejourDecouverteMapsCard extends StatefulWidget {
  final String text;
  final bool isSejour;
  final String? emplacement;
  const SejourDecouverteMapsCard(
      {super.key, required this.text, this.isSejour = true, this.emplacement});

  @override
  State<SejourDecouverteMapsCard> createState() => _MapsDatetimeCardState();
}

class _MapsDatetimeCardState extends State<SejourDecouverteMapsCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Container(
        //  margin: const EdgeInsets.all(10),
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
            widget.isSejour == true
                ? SejourDecouverteTravel(
                    text: widget.text,
                    emplacement: widget.emplacement ?? 'aucun emplacement',
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Lieu de rassemblement"),
                      GestureDetector(
                        onTap: () {
                          AppHelpersCommon.showCustomModalBottomSheet(
                            context: context,
                            modal: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 24),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(Icons.close,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: homeController
                                          .lieuxDeRassemblement.length,
                                      itemBuilder: (context, index) {
                                        final lieu = homeController
                                            .lieuxDeRassemblement[index];
                                        return ListTile(
                                          title: Text(
                                            lieu,
                                            style: const TextStyle(
                                                color: AppColors.black),
                                          ),
                                          onTap: () {
                                            homeController.selectedLieu.value =
                                                lieu;
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isDarkMode: false,
                            isDrag: true,
                            radius: 12,
                          );
                        },
                        child: Obx(() => Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: AppColors.gray),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                homeController.selectedLieu.value,
                                style: AppColors.interBold(size: 12),
                              ),
                            )),
                      ),
                    ],
                  ),
            Container(
              padding: const EdgeInsets.only(
                  left: AppDefaults.padding, right: AppDefaults.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppDivider(),
                  Text(
                    "Période de réservation",
                    style: AppColors.interBold(
                      size: 12,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: AppColors.black),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(homeController.displayLocationPeriodText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
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
