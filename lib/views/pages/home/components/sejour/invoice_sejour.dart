import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/models/hotel_invoice_model.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider%202.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/components/invoice_sejour_details.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:voyagedifiant/views/pages/pdf/hotel_facture_pdf.dart';

class InvoiceSejourPage extends StatefulWidget {
  const InvoiceSejourPage({super.key});

  @override
  State<InvoiceSejourPage> createState() => _InvoiceSejourPageState();
}

class _InvoiceSejourPageState extends State<InvoiceSejourPage> {
  final user = AppHelpersCommon.getUserInLocalStorage();
  HomeController homeController = Get.find();
  bool isAvailable = false;
  int amount = 0;
  final double alternateAmount = 200;
  final TextEditingController amountController = TextEditingController();

  late final HotelInvoiceModel hotelInfo;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    hotelInfo = HotelInvoiceModel.fromJson(Get.arguments);
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
      int totalPrice = hotelInfo.totalPrice;
      if (isAvailable) {
        amount = totalPrice;
        amountController.text = amount.toStringAsFixed(0);
      } else {
        amount = 0;
        amountController.text = '';
      }
    });
  }

  Future<void> handleButtonPressed() async {
    final Map<String, dynamic> invoiceData = Get.arguments;

    int montantPaye;
    if (isAvailable) {
      montantPaye = invoiceData['total_price'];
    } else {
      montantPaye = int.tryParse(amountController.text) ?? 0;
      if (montantPaye <= 0 || montantPaye > invoiceData['total_price']) {
        Get.snackbar('Erreur', 'Montant saisi invalide',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
    }

    setState(() => isLoading = true);

    try {
      final cleanedData = Map<String, dynamic>.from(invoiceData);
      cleanedData.remove('total_price_operation');
      cleanedData.remove('description_fr');
      cleanedData.remove('description_en');
      cleanedData['username'] = user!.name;
      cleanedData['phone'] = user!.phone;
      cleanedData['montantApaye'] = montantPaye;

      await homeController.saveHotelInvoiceToDatabase(context, cleanedData);
      cleanedData['email'] = user!.email;
      homeController.onSendInvoiceButtonPressed(cleanedData);
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = hotelInfo.totalPrice;
    final currentLocale = Get.locale?.languageCode ?? 'fr';
    final description = currentLocale == 'en'
        ? hotelInfo.descriptionEn
        : hotelInfo.descriptionFr;
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
            //const InvoiceSejourDetailsComponent(),
            Container(
              margin: const EdgeInsets.all(10),
              //padding: const EdgeInsets.all(AppDefaults.padding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                    width: 0.2,
                  ),
                  right: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                    width: 0.2,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                    width: 0.2,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDefaults.margin),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Résumé de la facture',
                        style: AppColors.interBold(
                            size: 16, color: AppColors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: Container(
                              // width: 180,
                              height: 130,
                              decoration: const BoxDecoration(
                                color: AppColors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/icons/hotpalm.png',
                                  ),
                                  // opacity: 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppDefaults.padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hotel',
                                  style: AppColors.interBold(
                                    size: 12,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(description,
                                  style: AppColors.interNormal(
                                    size: 12,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              FractionallySizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset('assets/icons/menage.png'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text('ménage'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset('assets/icons/wifi.png'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text('wifi'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset('assets/icons/hamb.png'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text('petit dej'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/location.png',
                                    color: AppColors.signUpColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(hotelInfo.city),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text('A partir de $hotelInfo',
                                  style: AppColors.interBold(
                                    size: 14,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildRowText('Chambre', hotelInfo.classe),
                  buildRowText('Localisation', hotelInfo.neighborhood),
                  buildRowText('Période de location', hotelInfo.rentalPeriod),
                  const AppDivider(),
                  buildRowText('Coût journalier', hotelInfo.price),
                  buildRowText('Coût total', hotelInfo.totalPriceOperation),
                  /*  
          const SizedBox(
            height: AppDefaults.padding,
          ),
          Center(
            child: Text(
              "BON A SAVOIR",
              style: AppColors.interBold(
                  size: 14, isUnderLine: true, underLineColor: AppColors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u2022 Un acompte de 10% est requis',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\u2022 Aucun remboursement n\'est effectué après paiement',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\u2022 Les frais de carburant sont à votre charge',
                ),
              ],
            ),
          ),*/
                  const SizedBox(
                    height: AppDefaults.padding,
                  ),
                ],
              ),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      if (!isAvailable) {
                        int? newAmount = int.tryParse(value);
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
                    onPressed: isLoading
                        ? null
                        : () async {
                            handleButtonPressed();
                          },
                    // () async {
                    /*  final Map<String, dynamic> invoiceData = Get.arguments;

                      int montantPaye;
                      if (isAvailable) {
                        montantPaye = invoiceData['total_price'];
                      } else {
                        montantPaye = int.tryParse(amountController.text) ?? 0;
                        if (montantPaye <= 0 ||
                            montantPaye > invoiceData['total_price']) {
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
                        cleanedData.remove('total_price_operation');
                        cleanedData.remove('description_fr');
                        cleanedData.remove('description_en');
                        cleanedData['username'] = user!.name;
                        cleanedData['phone'] = user!.phone;
                        cleanedData['montantApaye'] = montantPaye;

                        await homeController.saveHotelInvoiceToDatabase(
                            context, cleanedData);
                        cleanedData['email'] = user!.email;
                        homeController.onSendInvoiceButtonPressed(cleanedData);
                      } catch (e) {
                        Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }*/
                    // },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    buttonText: isLoading ? 'En cours...' : "Régler la facture",
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

  Widget buildRowText(String name, String? info) {
    return FractionallySizedBox(
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Row(
          children: [
            Text(
              '$name :',
              style: AppColors.interBold(
                size: 14,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                info!,
                style: AppColors.interNormal(
                  size: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
