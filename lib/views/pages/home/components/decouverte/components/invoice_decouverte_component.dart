import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/models/discovery_invoice_model.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class InvoiceDecouverteDetailsComponent extends StatefulWidget {
  const InvoiceDecouverteDetailsComponent({
    super.key,
  });

  @override
  State<InvoiceDecouverteDetailsComponent> createState() =>
      _InvoiceDecouverteDetailsComponentState();
}

class _InvoiceDecouverteDetailsComponentState
    extends State<InvoiceDecouverteDetailsComponent> {
  final user = AppHelpersCommon.getUserInLocalStorage();
  HomeController homeController = Get.find();
  bool isAvailable = false;
  int amount = 0;
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
      int totalPrice = discoveryeInfo.totalPrice;
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
    int totalPrice = discoveryeInfo.totalPrice;
    return 
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
                style: AppColors.interBold(size: 16, color: AppColors.white),
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
                        borderRadius: BorderRadius.all(Radius.circular(4)),
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
          buildRowText('Période de location', discoveryeInfo.reservationPeriod),
          const AppDivider(),
          buildRowText('Coût journalier', discoveryeInfo.price),
          buildRowText('Coût total', discoveryeInfo.totalPriceOperation),
          const SizedBox(
            height: AppDefaults.padding,
          ),
        ],
      ),
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
