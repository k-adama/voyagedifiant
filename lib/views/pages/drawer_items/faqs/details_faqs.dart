import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
class DetailsFaqsPage extends StatefulWidget {
  const DetailsFaqsPage({super.key});

  @override
  State<DetailsFaqsPage> createState() => _DetailsFaqsPageState();
}

class _DetailsFaqsPageState extends State<DetailsFaqsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Supprime l'ombre
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.language_outlined)
            )
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("FAQ / COMMENT CA MARCHE",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))
              ],
            ),
          ),
        ),
        body:SafeArea(
        child: Padding(padding: EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            SizedBox(height: Get.height/18,),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 
            style: TextStyle(
                fontSize: 18
            ),)
          ],
        ),
            )
        )
    );
  }
}