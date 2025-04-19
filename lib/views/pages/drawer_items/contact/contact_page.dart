import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class ContactUsPage extends StatelessWidget {
  final String phoneNumber = "+225 0749468616";
  final String address = "Angré nouveau chu";

  ContactUsPage({super.key});
  final Uri whatsappUrl = Uri.parse("https://wa.me/+2250749468616");

  void callPhoneNumber(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Impossible de lancer un appel vers $phoneNumber';
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("NOUS CONTACTER",
                style: AppColors.interBold(
                  size: 18,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 5,),
                        const Icon(Icons.location_on,
                            color: AppColors.signUpColor, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            address,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1, height: 25, color: Colors.grey[300]),
                    GestureDetector(
                      onTap: () async {
                        callPhoneNumber(phoneNumber);
                      },
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * 0.9,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: AppDefaults.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: AppColors.signUpColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    phoneNumber,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(thickness: 1, height: 25, color: Colors.grey[300]),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        launchUrl(whatsappUrl);
                      },
                      //_openWhatsApp,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * 0.9,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: AppDefaults.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/whatsp-removebg-preview.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    "Nous contacter sur WhatsApp",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
