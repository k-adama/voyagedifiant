// import 'package:flutter/material.dart';

// class TravelPageComponent extends StatefulWidget {
//   const TravelPageComponent({super.key});

//   @override
//   State<TravelPageComponent> createState() => _TravelPageComponentState();
// }

// class _TravelPageComponentState extends State<TravelPageComponent> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Column(
//           children: [
//             Icon(Icons.directions_car, size: 20),
//             SizedBox(
//               height: 20, // Hauteur de la barre verticale
//               child: VerticalDivider(color: Colors.black),
//             ),
//             Icon(Icons.directions_car, size: 20),
//           ],
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _showSearchBottomSheet("Choisissez votre position ", context);
//                 },
//                 // onTap: () => _showSearchBottomSheet("Localisation actuelle"),
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   height: 35,
//                   color: Colors.blue[100],
//                   child: Text(
//                     "currentLocation",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               // GestureDetector(
//               //   onTap: () {},
//               //   child: Container(
//               //     padding: EdgeInsets.all(16),
//               //     color: Colors.blue[100],
//               //     child: Text('currentLocation'),
//               //   ),
//               // ),
//               GestureDetector(
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   height: 35,
//                   color: Colors.green[100],
//                   child: Text(
//                     "destination",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               // GestureDetector(
//               //   onTap: () {},
//               //   child: Container(
//               //     padding: EdgeInsets.all(16),
//               //     color: Colors.green[100],
//               //     child: Text('destination'),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// void _showSearchBottomSheet(String title, dynamic context) {
//   final TextEditingController _searchController = TextEditingController();
//   List<String> _suggestions = [
//     "Abidjan",
//     "Yamoussoukro",
//     "Bouaké",
//     "San-Pédro"
//   ];
//   List<String> _filteredSuggestions = [];

//   showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     isScrollControlled: true, // Permet d'afficher en grand
//     builder: (BuildContext context) {
//       return DraggableScrollableSheet(
//         expand: true,
//         initialChildSize: 0.9, // Occupe 90% de l'écran
//         minChildSize: 0.9,
//         maxChildSize: 1.0,
//         builder: (_, scrollController) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Titre et bouton de fermeture
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(title,
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         IconButton(
//                           icon: const Icon(Icons.close),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),

//                     // Barre de recherche
//                     TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: "Recherchez une position...",
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onChanged: (query) {
//                         setState(() {
//                           _filteredSuggestions = _suggestions
//                               .where((item) => item
//                                   .toLowerCase()
//                                   .contains(query.toLowerCase()))
//                               .toList();
//                         });
//                       },
//                     ),

//                     const SizedBox(height: 10),

//                     // Liste des suggestions
//                     Expanded(
//                       child: ListView.builder(
//                         controller: scrollController,
//                         itemCount: _filteredSuggestions.isEmpty
//                             ? _suggestions.length
//                             : _filteredSuggestions.length,
//                         itemBuilder: (context, index) {
//                           String location = _filteredSuggestions.isEmpty
//                               ? _suggestions[index]
//                               : _filteredSuggestions[index];

//                           return ListTile(
//                             leading: const Icon(Icons.location_on),
//                             title: Text(location),
//                             onTap: () {
//                               _searchController.text = location;
//                               Navigator.of(context).pop();
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/app_divider%202.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';

class TravelPageComponent extends StatefulWidget {
  const TravelPageComponent({super.key});

  @override
  State<TravelPageComponent> createState() => _TravelPageComponentState();
}

class _TravelPageComponentState extends State<TravelPageComponent> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [
    "Abidjan",
    "Yamoussoukro",
    "Bouaké",
    "San-Pédro"
  ];
  List<String> _filteredSuggestions = [];

  // Variables pour stocker la localisation et la destination choisies
  String _currentLocation = "currentLocation";
  String _destination = "destination";

  void _showSearchBottomSheet(String title, bool isCurrentLocation) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true, // Permet d'afficher en grand
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.9, // Occupe 90% de l'écran
          minChildSize: 0.9,
          maxChildSize: 1.0,
          builder: (_, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre et bouton de fermeture
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SearchBarComponent(text: "Recherchez une position"),
                      // Barre de recherche
                      // TextField(
                      //   controller: _searchController,
                      //   decoration: InputDecoration(
                      //     hintText: "Recherchez une position...",
                      //     prefixIcon: const Icon(Icons.search),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   onChanged: (query) {
                      //     setState(() {
                      //       _filteredSuggestions = _suggestions
                      //           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                      //           .toList();
                      //     });
                      //   },
                      // ),

                      const SizedBox(height: 10),

                      // Liste des suggestions
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _filteredSuggestions.isEmpty
                              ? _suggestions.length
                              : _filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            String location = _filteredSuggestions.isEmpty
                                ? _suggestions[index]
                                : _filteredSuggestions[index];

                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                location,
                              ),
                              onTap: () {
                                // Met à jour la valeur affichée
                                setState(() {
                                  if (isCurrentLocation) {
                                    _currentLocation = location;
                                  } else {
                                    _destination = location;
                                  }
                                });

                                // Ferme le bottom sheet
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Lieu de prise en charge"),
                GestureDetector(
                  onTap: () =>
                      _showSearchBottomSheet("Localisation actuelle", true),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      _currentLocation,
                      style: AppColors.interBold(size: 12),
                    ),
                  ),
                ),
              ],
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Lieu de restitution"),
                GestureDetector(
                  onTap: () => _showSearchBottomSheet("Destination", false),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      _destination,
                      style: AppColors.interBold(size: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
