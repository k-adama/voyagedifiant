import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_icons.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

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
                Text("FAQS",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))
              ],
            ),
          ),
        ),
        body: Padding(padding: EdgeInsets.all(AppDefaults.padding),
        child: Column(
           children: [
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAILS_FAQS);
              },
            leading: Text("Comment ça marche",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18,),
            ),
            Divider(
              thickness: 2,
            ),
              ListTile(
              onTap: () {
                 Get.toNamed(Routes.DETAILS_FAQS);
              },
            leading: Text("Comment ça marche",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18,),
            ),
            Divider(
              thickness: 2,
            ),
              ListTile(
              onTap: () {
                 Get.toNamed(Routes.DETAILS_FAQS);
              },
            leading: Text("Comment ça marche",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18,),
            ),
            Divider(
              thickness: 2,
            ),
              ListTile(
              onTap: () {
                 Get.toNamed(Routes.DETAILS_FAQS);
              },
            leading: Text("Comment ça marche",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18,),
            ),
            Divider(
              thickness: 2,
            ),
            Spacer(),
           AppCustomButton(onPressed:(){} , buttonText: "Contactez le support", 
            textColor: AppColors.white,
            buttonColor: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
            ),
            SizedBox(height: 45,)
           ],
        ),
        ),
    );
  }
}