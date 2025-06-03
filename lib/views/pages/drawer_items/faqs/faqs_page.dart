import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider%202.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          TranslatePopItem(
            isDrawer: true,
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            Text("FAQS",
                style: AppColors.interBold(
                  size: 18,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAILS_FAQS);
              },
              leading: const Text(
                "Comment ça marche",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
            AppDivider(),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAILS_FAQS);
              },
              leading: Text(
                "Comment ça marche",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
            AppDivider(),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAILS_FAQS);
              },
              leading: Text(
                "Comment ça marche",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
            AppDivider(),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAILS_FAQS);
              },
              leading: Text(
                "Comment ça marche",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
            const Spacer(),
            AppCustomButton(
              onPressed: () async{
                Get.toNamed(Routes.CONTACT_PAGE);
              },
              buttonText: "Contactez le support",
              textColor: AppColors.white,
              buttonColor: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            SizedBox(
              height: 45,
            )
          ],
        ),
      ),
    );
  }
}
