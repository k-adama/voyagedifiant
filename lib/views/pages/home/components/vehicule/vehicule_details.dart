import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/components/drawer_page.component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/details_card_component.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Image.asset(
            'assets/icons/logo-voyage.png',
            height: 40,
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          // leading: ,
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: AppColors.white,
        child: DrawerPageComponent(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailsCardComponent(
              name: 'HUNDAI',
              price: '13000',
              person: '03',
              bag: '01',
              color: const Color(0xFF402FBE),
              couponBackground: 'assets/images/Rectangle 11.png',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
