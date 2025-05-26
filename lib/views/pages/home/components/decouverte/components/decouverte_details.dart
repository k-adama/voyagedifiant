import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/product_images_slider.dart';
import 'package:voyagedifiant/core/widgets/components/sejour_decouverte_maps_card.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class DecouverteDetails extends StatefulWidget {
  const DecouverteDetails({super.key});

  @override
  State<DecouverteDetails> createState() => _DecouverteDetailsState();
}

class _DecouverteDetailsState extends State<DecouverteDetails> {
  final TouristicDiscovery? touristicSite = Get.arguments;
  String? selectedClass;

  void selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Get.locale?.languageCode ?? 'fr';
    final description = currentLocale == 'en'
        ? touristicSite!.descriptionEn
        : touristicSite!.descriptionFr;
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
                const ProductImagesSlider(
                  images: [
                    'assets/icons/Cascade.png',
                    'assets/icons/Cascade.png',
                    'assets/icons/Cascade.png',
                  ],
                ),
                /*Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/icons/Cascade.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    border: Border.all(
                      color: AppColors.gray,
                      width: 1,
                    ),
                  ),
                ),*/
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Historique",
                  style: AppColors.interBold(
                    size: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      color: AppColors.signUpColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      touristicSite!.name ?? '',
                      style: AppColors.interBold(
                        size: 14,
                        color: AppColors.signUpColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description ?? '',
                  style: AppColors.interNormal(
                    size: 12,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildClassButton(
                    'Standard', touristicSite!.standardPrice.toString()),
                _buildClassButton(
                    'Premium', touristicSite!.premiumPrice.toString()),
                _buildClassButton('Suite', '3000'),
                const SizedBox(
                  height: 30,
                ),
                const SejourDecouverteMapsCard(
                  isSejour: false,
                  text: "Emplacement",
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.5,
                    child: AppCustomButton(
                      onPressed: () {
                      /*  homeController.goToTouristicSiteInvoicePage(
                            touristicSite, selectedClass);*/
                        Get.toNamed(Routes.INVOICE_DECOUVERTE_PAGE);
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      buttonText: "Réserver maintenant",
                      textColor: AppColors.white,
                      buttonColor: AppColors.primaryColor,
                    ),
                  ),
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
                flex: 4,
                child: Text('A partir de $price/2h',
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
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Text(
                      className,
                      style: const TextStyle(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (className == 'Premium') const Text('Avec transport'),
          RatingBar.builder(
            initialRating: 3.5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            unratedColor: AppColors.primaryColor,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: AppColors.signUpColor),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    );
  }
}
