import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class InvoiceSejourDetailsComponent extends StatefulWidget {
  const InvoiceSejourDetailsComponent({
    super.key,
  });

  @override
  State<InvoiceSejourDetailsComponent> createState() =>
      _InvoiceSejourDetailsComponentState();
}

class _InvoiceSejourDetailsComponentState
    extends State<InvoiceSejourDetailsComponent> {
  String? selectedClass;

  void selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      decoration: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: AppDefaults.borderRadius,
                        image: const DecorationImage(
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
                      Text('description' ?? '',
                          style: AppColors.interNormal(
                            size: 12,
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      FractionallySizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Image.asset('assets/icons/location.png'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('location'),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('A partir de 5000',
                          style: AppColors.interBold(
                            size: 14,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          buildRowText('Chambre', 'Standard'),
          buildRowText('Localisation', 'Yamoussoukro'),
          buildRowText('Période de location', '04 Nov - 07 Nov'),
          const AppDivider(),
          buildRowText('Coût journalier', '2000'),
          buildRowText('Coût total', '360000'),
          /*  const SizedBox(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
