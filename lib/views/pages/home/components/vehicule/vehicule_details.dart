import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/details_card_component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/maps_datetime_card.dart';

class VehiculeDetails extends StatefulWidget {
  const VehiculeDetails({super.key});

  @override
  State<VehiculeDetails> createState() => _VehiculeDetailsState();
}

class _VehiculeDetailsState extends State<VehiculeDetails> {
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
              const DetailsCardComponent(
                name: 'HUNDAI',
                price: '13000',
                person: '03',
                bag: '01',
                couponBackground: 'assets/images/Rectangle 11.png',
              ),
              const MapsDatetimeCard(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppCustomButton(
                  onPressed: () {
                    //  Get.offAllNamed(Routes.HOME_PAGE);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  buttonText: "Passer au paiement",
                  textColor: AppColors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
