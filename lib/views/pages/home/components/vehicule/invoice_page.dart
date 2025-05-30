import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/app_translate.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:open_file/open_file.dart';
import 'package:voyagedifiant/core/models/VehiculeInvoiceModel.dart';

import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/dialogs/successfull.dialog.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/invoice_details_component.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/components/invoice_pdf_service.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final user = AppHelpersCommon.getUserInLocalStorage();
  HomeController homeController = Get.find();
  bool isAvailable = false;
  double amount = 0;
  final double alternateAmount = 200;
  final TextEditingController amountController = TextEditingController();

  late final VehiculeInvoiceModel vehiculeInfo;

  @override
  void initState() {
    super.initState();
    vehiculeInfo = VehiculeInvoiceModel.fromJson(Get.arguments);
    amountController.text = '';
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _togglePayment(bool value) {
    setState(() {
      isAvailable = value;
      double totalPrice = vehiculeInfo.totalPrice;
      if (isAvailable) {
        amount = totalPrice;
        amountController.text = amount.toStringAsFixed(2);
      } else {
        amount = 0;
        amountController.text = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = vehiculeInfo.totalPrice;
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
            InvoiceDetailsComponent(
              name: vehiculeInfo.name,
              price: '13000',
              person: vehiculeInfo.person,
              bag: vehiculeInfo.bag,
              airConditioning: vehiculeInfo.airConditioning,
              couponBackground: 'assets/images/Rectangle 11.png',
              classe: vehiculeInfo.classe,
              lieuDePriseEnCharge: '',
              lieuDeRestitution: '',
              periodeDeLocation: vehiculeInfo.locationVehiclePeriod,
              driverName: vehiculeInfo.driver,
              coutJournalier: vehiculeInfo.price,
              coutTotal: vehiculeInfo.totalPriceOperation,
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
                          color: AppColors.primaryColor,
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
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                            ),
                            borderWidth: 4.0,
                            onChanged: _togglePayment,
                            styleBuilder: (b) => ToggleStyle(
                                indicatorColor: isAvailable
                                    ? AppColors.white
                                    : AppColors.primaryColor),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    enabled: !isAvailable,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      if (!isAvailable) {
                        double? newAmount = double.tryParse(value);
                        if (newAmount != null && newAmount < totalPrice) {
                          amount = newAmount;
                        } else {
                          Get.snackbar(
                              'Montant invalide',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              'Le montant ne doit pas être égal ou supérieur à ${totalPrice.toStringAsFixed(2)} FCFA');
                          amountController.text = '';
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: 0.5,
                  child: AppCustomButton(
                    onPressed: () async {
                      final Map<String, dynamic> invoiceData = Get.arguments;

                      // Récupérer le montant payé
                      double montantPaye;
                      if (isAvailable) {
                        montantPaye = invoiceData['totalPrice'];
                      } else {
                        montantPaye =
                            double.tryParse(amountController.text) ?? 0;
                        if (montantPaye <= 0 ||
                            montantPaye > invoiceData['totalPrice']) {
                          Get.snackbar('Erreur', 'Montant saisi invalide',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                          return;
                        }
                      }

                      try {
                        final cleanedData =
                            Map<String, dynamic>.from(invoiceData);
                        cleanedData.remove('totalPriceOperation');
                        cleanedData['username'] = user!.name;
                        cleanedData['phone'] = user!.phone;
                        cleanedData['montantApaye'] = montantPaye;
                        /* cleanedData['datePaiement'] =
                            DateTime.now().toIso8601String();*/

                        await homeController.saveInvoiceToDatabase(
                            context, cleanedData);

                        Get.snackbar(
                            'Succès', 'Facture enregistrée avec succès',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green,
                            colorText: Colors.white);

                        Get.back();
                      } catch (e) {
                        Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                      /* AppHelpersCommon.showAlertDialog(
                        context: context,
                        canPop: false,
                        child: SuccessfullDialog(
                          isCustomerAdded: false,
                          haveButton: false,
                          svgPicture:
                              "assets/icons/undraw_happy_news_re_tsbd 1.svg",
                          content: '',
                          redirect: () => Get.close(1),
                        ),
                      );*/
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    buttonText: "Régler la facture",
                    textColor: AppColors.white,
                    buttonColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
