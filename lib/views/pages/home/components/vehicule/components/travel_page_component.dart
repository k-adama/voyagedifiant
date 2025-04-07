import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/SearchBottomSheetComponent.dart';

class TravelPageComponent extends StatefulWidget {
  const TravelPageComponent({super.key});

  @override
  State<TravelPageComponent> createState() => _TravelPageComponentState();
}

class _TravelPageComponentState extends State<TravelPageComponent> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _suggestions = [
    "Abidjan",
    "Yamoussoukro",
    "Bouaké",
    "San-Pédro"
  ];
  List<String> _filteredSuggestions = [];

  // Variables pour stocker la localisation et la destination choisies
  String _currentLocation = "currentLocation";
  String _destination = "destination";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.directions_car,
                size: 20,
                color: AppColors.signUpColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lieu de prise en charge"),
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
                          border:
                              Border(bottom: BorderSide(color: AppColors.gray)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _currentLocation,
                          style: AppColors.interBold(size: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
            child: VerticalDivider(color: Colors.black),
          ),
          Row(
            children: [
              const Icon(
                Icons.directions_car,
                size: 20,
                color: AppColors.signUpColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lieu de restitution"),
                    GestureDetector(
                      onTap: () {
                        SearchBottomSheetComponent.show(
                          context: context,
                          title: "Destination",
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
                          border:
                              Border(bottom: BorderSide(color: AppColors.gray)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _destination,
                          style: AppColors.interBold(size: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
