import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/SearchBottomSheetComponent.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

//...............;

  var _controller = TextEditingController();

  final Uuid uuid = const Uuid();
  String? _sessionToken;

  void _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

void getSuggestion(String input) async {
  print('Texte saisi : $input');

  String kPLACES_API_KEY = "AIzaSyBANHYarQulwIc6C9qBnTsj-8XBW4x72qc";
  String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  
  print('URL de la requête : $request');

  var response = await http.get(Uri.parse(request));

  print('Status code de la réponse : ${response.statusCode}');
  print('Réponse brute : ${response.body}');

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print('Prédictions reçues : ${data['predictions']}');

    setState(() {
      _placeList = data['predictions'];
    });
  } else {
    print('Erreur lors de la requête');
    throw Exception('Failed to load predictions');
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Seek your location here",
                  focusColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(Icons.map),
               
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_placeList[index]["description"]),
                );
              },
            )
         /* Row(
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
                          suggestions: _placeList
                              .map<String>((e) => e["description"] as String)
                              .toList(),
                          onLocationSelected: (selected) {
                            _currentLocation = selected;
                            // setState() si nécessaire
                          },
                          itemCount: _placeList.length,
                          // text: _placeList[index]["description"],
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
          ),*/,
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
                          controller: _controller,
                          context: context,
                          title: "Destination",
                          isCurrentLocation: true,
                          suggestions: _placeList
                              .map<String>((e) => e["description"] as String)
                              .toList(),
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
