import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
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
    required this.classe,
    required this.lieuDePriseEnCharge,
    required this.lieuDeRestitution,
    required this.periodeDeLocation,
    required this.driverName,
    required this.coutJournalier,
    required this.coutTotal,
    required this.airConditioning,
  });

  final String? couponBackground;
  final String name;
  final String price;
  final String person;
  final String bag;
  final String airConditioning;
  final Color? color;
  final String classe;
  final String lieuDePriseEnCharge;
  final String lieuDeRestitution;
  final String periodeDeLocation;
  final String driverName;
  final String coutJournalier;
  final String coutTotal;

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
                        flex: 4,
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
                                      size: 14,
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
                                          Text(
                                            '${widget.person} passagers',
                                            style: AppColors.interNormal(
                                              color: AppColors.white,
                                              size: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
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
                                          Text(
                                            '${widget.bag} valise(s)',
                                            style: AppColors.interNormal(
                                              color: AppColors.white,
                                              size: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
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
                                          Text(
                                            '${widget.airConditioning} climatisation',
                                            style: AppColors.interNormal(
                                              color: AppColors.white,
                                              size: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
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
                                          Text(
                                            '${widget.bag} valise(s)',
                                            style: AppColors.interNormal(
                                              color: AppColors.white,
                                              size: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
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
          buildRowText('Classe', widget.classe),
          buildRowText('Lieu de prise en charge', widget.lieuDePriseEnCharge),
          buildRowText('Lieu de restitution', widget.lieuDeRestitution),
          buildRowText('Période de location', widget.periodeDeLocation),
          buildRowText('Chauffeur', widget.driverName),
          const AppDivider(),
          buildRowText('Coût journalier', widget.coutJournalier),
          buildRowText('Coût total', widget.coutTotal),
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
