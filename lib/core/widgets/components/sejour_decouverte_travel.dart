import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/SearchBottomSheetComponent.dart';

class SejourDecouverteTravel extends StatefulWidget {
  const SejourDecouverteTravel({super.key});

  @override
  State<SejourDecouverteTravel> createState() => _SejourDecouverteTravelState();
}

class _SejourDecouverteTravelState extends State<SejourDecouverteTravel> {
  String _currentLocation = "currentLocation";
  String _destination = "destination";

  final List<String> _suggestions = [
    "Abidjan",
    "Yamoussoukro",
    "Bouaké",
    "San-Pédro"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Emplacement"),
          const SizedBox(
            height: 10,
          ),
          Container(
            //width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Yamoussoukro, cité milliardaires',
              style: AppColors.interBold(size: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Lieu de prise en charge"),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              SearchBottomSheetComponent.show(
                context: context,
                title: "Localisation actuelle",
                isCurrentLocation: true,
                suggestions: _suggestions,
                onLocationSelected: (selected) {
                  _currentLocation = selected;
                  // setState() si nécessaire
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 35,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '_currentLocation',
                style: AppColors.interBold(size: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
