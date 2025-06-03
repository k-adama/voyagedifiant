import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/app_translate.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/models/vehicule.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/details_card_component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/maps_datetime_card.dart';

class VehiculeDetails extends StatefulWidget {
  const VehiculeDetails({
    super.key,
  });

  @override
  State<VehiculeDetails> createState() => _VehiculeDetailsState();
}

class _VehiculeDetailsState extends State<VehiculeDetails> {
  String? selectedClass;
  Color _buttonColor = AppColors.primaryColor;
  final VehicleModel? vehicle = Get.arguments;
  HomeController homeController = Get.find();

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
              DetailsCardComponent(
                name: vehicle?.name ?? '',
                price: vehicle?.economyPrice.toString() ?? '',
                businessPrice: vehicle?.businessPrice.toString() ?? '',
                person: vehicle?.numberOfSeats.toString() ?? '',
                bag: vehicle?.luggage.toString() ?? '',
                couponBackground:
                    // vehicle?.imageUrl ??
                    'assets/images/Rectangle 11.png',
                airConditioning:
                    (vehicle?.airConditioning ?? false) ? '1' : '0',
                onClassSelected: (value) {
                  setState(() {
                    selectedClass = value;
                  });
                },
              ),
              const MapsDatetimeCard(),
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "BON A SAVOIR",
                          style: AppColors.interBold(
                            size: 16,
                            color: AppColors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Image.asset(
                              'assets/icons/eco-fuel_13104616 1.png',
                              width: 24,
                              height: 24,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Les frais de carburants sont à vos charges",
                                style: AppColors.interNormal(
                                  size: 14,
                                  color: AppColors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Image.asset('assets/icons/tdesign_money.png',
                                width: 24, height: 24, color: AppColors.white),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Vous payez un acompte de 10% non remboursable",
                                style: AppColors.interNormal(
                                  color: AppColors.white,
                                  size: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.5,
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _buttonColor = AppColors.signUpColor;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _buttonColor = AppColors.primaryColor;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _buttonColor = AppColors.primaryColor;
                        });
                      },
                      child: AppCustomButton(
                        onPressed: () async{
                          homeController.goToVehiculeInvoicePage(
                              vehicle, selectedClass);
                        },
                        borderRadius: AppDefaults.borderRadius,
                        buttonText: "Passer au paiement",
                        textColor: AppColors.white,
                        buttonColor: _buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
