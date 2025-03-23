import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page_body.component.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page_header.component.dart';

class DrawerPageComponent extends StatelessWidget {
  const DrawerPageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Center(child: DrawerPageHearderComponent())),
          const DrawerPageBodyComponent(),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.logout,
                    color: AppColors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Se déconnecter",
                      style: AppColors.interBold(
                        size: 15,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
