import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  final String phoneNumber = "0749468616";
  final String countryCode = "225";
  final String address = "Angré nouveau chu";

  const ContactUsPage({super.key});

  void _openWhatsApp() async {
    final String fullNumber = "$countryCode$phoneNumber";
    final Uri whatsappUrl = Uri.parse("https://wa.me/$fullNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Impossible d'ouvrir WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Supprime l'ombre
        title: Text(
          "Nous contacter",
          style: AppColors.interBold(
            size: 16,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.language_outlined))
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
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
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.green, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          phoneNumber,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, height: 25, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _openWhatsApp,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/whatsapp.jpg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Nous contacter sur WhatsApp",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
