import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/models/discovery_invoice_model.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider%202.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/dialogs/successfull.dialog.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/components/invoice_decouverte_component.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class InvoiceDecouvertePage extends StatefulWidget {
  const InvoiceDecouvertePage({super.key});

  @override
  State<InvoiceDecouvertePage> createState() => _InvoiceDecouvertePageState();
}

class _InvoiceDecouvertePageState extends State<InvoiceDecouvertePage> {
  final user = AppHelpersCommon.getUserInLocalStorage();
  HomeController homeController = Get.find();
  bool isAvailable = false;
  double amount = 0;
  final double alternateAmount = 200;
  final TextEditingController amountController = TextEditingController();

  late final DiscoveryInvoiceModel discoveryeInfo;

  @override
  void initState() {
    super.initState();
    discoveryeInfo = DiscoveryInvoiceModel.fromJson(Get.arguments);
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
      double totalPrice = discoveryeInfo.totalPrice;
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
    double totalPrice = discoveryeInfo.totalPrice;
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
            //  const InvoiceDecouverteDetailsComponent(),
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
                                    'assets/icons/Cascade.png',
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
                              Text(discoveryeInfo.name,
                                  style: AppColors.interBold(
                                    size: 12,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Text('description' ?? '',
                                  style: AppColors.interNormal(
                                    size: 12,
                                  )),
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
                                  Text(
                                    'Man',
                                    style: AppColors.interBold(
                                      size: 14,
                                      color: AppColors.signUpColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildRowText('Visite', discoveryeInfo.classe),
                  buildRowText('Localisation', 'Yamoussoukro'),
                  buildRowText(
                      'Période de location', discoveryeInfo.reservationPeriod),
                  const AppDivider(),
                  buildRowText('Coût journalier', discoveryeInfo.price),
                  buildRowText(
                      'Coût total', discoveryeInfo.totalPriceOperation),
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
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildRowText(String name, String info) {
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
                info,
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
