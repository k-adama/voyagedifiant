import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/details_card_component.dart';

class VehiculeDetails extends StatefulWidget {
  const VehiculeDetails({super.key});

  @override
  State<VehiculeDetails> createState() => _VehiculeDetailsState();
}

class _VehiculeDetailsState extends State<VehiculeDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarComponent(),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        child: DrawerPageComponent(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              DetailsCardComponent(
                name: 'HUNDAI',
                price: '13000',
                person: '03',
                bag: '01',
                couponBackground: 'assets/images/Rectangle 11.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
