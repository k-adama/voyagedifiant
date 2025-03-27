import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/dialogs/successfull.dialog.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/invoice_details_component.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  bool isAvailable = false;
  double amount = 100;
  final double alternateAmount = 200;
  void _togglePayment(bool value) {
    setState(() {
      isAvailable = value;
      amount = value ? alternateAmount : 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const InvoiceDetailsComponent(
              name: 'HUNDAI',
              price: '13000',
              person: '03',
              bag: '01',
              couponBackground: 'assets/images/Rectangle 11.png',
            ),
            const SizedBox(
              height: AppDefaults.padding,
            ),
            Center(
              child: Text(
                "REGLEMENT DE LA FACTURE",
                style: AppColors.interBold(
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paiement total",
                        style: AppColors.interBold(
                          size: 14,
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          width: 50,
                          child: AnimatedToggleSwitch<bool>.dual(
                            current: isAvailable,
                            first: false,
                            second: true,
                            spacing: 4.0,
                            style: ToggleStyle(
                              borderColor: AppColors.gray,
                              backgroundColor: isAvailable
                                  ? AppColors.signUpColor
                                  : AppColors.white,
                            ),
                            borderWidth: 4.0,
                            onChanged: _togglePayment,
                            styleBuilder: (b) => const ToggleStyle(
                                indicatorColor: AppColors.primaryColor),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: amount.toStringAsFixed(2),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        amount = double.tryParse(value) ?? amount;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppCustomButton(
                onPressed: () {
                  AppHelpersCommon.showAlertDialog(
                    context: context,
                    canPop: false,
                    child: SuccessfullDialog(
                      isCustomerAdded: false,
                      haveButton: false,
                      // title: "Paiement effectué",
                      svgPicture:
                          "assets/icons/undraw_happy_news_re_tsbd 1.svg",
                      content: 'Paiement effectué',
                      redirect: () {
                        Get.close(1);
                      },
                    ),
                  );
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                buttonText: "Régler la facture",
                textColor: AppColors.white,
                buttonColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
