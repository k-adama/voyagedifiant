import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/sejour_decouverte_maps_card.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/driver_cart_component.dart';

class SejourDetails extends StatefulWidget {
  const SejourDetails({super.key});

  @override
  State<SejourDetails> createState() => _SejourDetailsState();
}

class _SejourDetailsState extends State<SejourDetails> {
  String? selectedClass;

  void selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/icons/hotpalm.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    border: Border.all(
                      color: AppColors.gray,
                      width: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/icons/lit.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('2 lits'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/solar_bath-linear.png',
                          width: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('2 salles de bains'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/clim.png',
                          width: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('3 climatiseurs'),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Détails",
                  style: AppColors.interBold(
                    size: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Excellent choix pour les voyageurs visitant Yamoussoukro, l'Hotel des Parlementaires offre de nombreux services conçus pour sublimer votre séjour. L'Hotel des Parlementaires est un hôtel proposant des chambres équipées d'une climatisation.",
                  style: AppColors.interNormal(
                    size: 12,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildClassButton('Standard', '3000'),
                _buildClassButton('Premium', '3000'),
                _buildClassButton('Suite', '3000'),
                const SizedBox(
                  height: 30,
                ),
                const SejourDecouverteMapsCard(
                  text: "Emplacement",
                ),
                /* Row(
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
                ),*/
                const SizedBox(
                  height: 30,
                ),
                AppCustomButton(
                  onPressed: () {
                    Get.toNamed(Routes.INVOICE_SEJOUR_PAGE);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  buttonText: "Enregister",
                  textColor: AppColors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildClassButton(String className, String price) {
    bool isSelected = selectedClass == className;
    return FractionallySizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text('A partir de $price/jour',
                    style: AppColors.interBold(
                      size: 12,
                    )),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedClass = isSelected ? null : className;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.signUpColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(className,
                        style: const TextStyle(color: AppColors.white)),
                  ),
                ),
              ),
            ],
          ),
          if (className == 'Standard') const Text('vue sur le balcon'),
          RatingBar.builder(
            initialRating: 3.5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    );
  }
}
