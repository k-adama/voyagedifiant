import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class InvoiceDetailsComponent extends StatefulWidget {
  const InvoiceDetailsComponent({
    super.key,
    this.couponBackground,
    required this.name,
    required this.price,
    required this.person,
    required this.bag,
    this.color,
  });

  final String? couponBackground;
  final String name;
  final String price;
  final String person;
  final String bag;
  final Color? color;

  @override
  State<InvoiceDetailsComponent> createState() =>
      _InvoiceDetailsComponentState();
}

class _InvoiceDetailsComponentState extends State<InvoiceDetailsComponent> {
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gray,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Material(
                  color: AppColors.transparent,
                  borderRadius: AppDefaults.borderRadius,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: widget.color ?? AppColors.transparent,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child:
                                    Image.asset(widget.couponBackground ?? '')),
                          )),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: AppColors.signUpColor,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name,
                                    style: AppColors.interBold(
                                      size: 20,
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                FractionallySizedBox(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/person_place.png',
                                            color: AppColors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text('${widget.person} passagers'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/bagage.png',
                                            color: AppColors.white,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text('${widget.bag} valise(s)'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/nature_16239240 1.png',
                                            color: AppColors.white,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text('${widget.bag} climatisation'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/siege.png',
                                            color: AppColors.white,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text('${widget.bag} valise(s)'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildRowText('Classe', 'Economie'),
          buildRowText('Lieu de prise en charge', 'Economie'),
          buildRowText('Lieu de restitution', 'Economie'),
          buildRowText('Période de location', 'Economie'),
          buildRowText('Chauffeur', 'Economie'),
          const AppDivider(),
          buildRowText('Coût journalier', '2000'),
          buildRowText('Coût total', '360000'),
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
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u2022 Un acompte de 10% est requis',
                  style: AppColors.interNormal(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\u2022 Aucun remboursement n\'est effectué après paiement',
                  style: AppColors.interNormal(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\u2022 Les frais de carburant sont à votre charge',
                  style: AppColors.interNormal(),
                ),
              ],
            ),
          ),
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
            Text(
              info,
              style: AppColors.interNormal(
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
