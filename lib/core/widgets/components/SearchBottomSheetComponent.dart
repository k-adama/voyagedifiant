import 'package:flutter/material.dart';

class SearchBottomSheetComponent {
  static void show({
    required BuildContext context,
    required String title,
    required bool isCurrentLocation,
    required Function(String selectedLocation) onLocationSelected,
    required List<String> suggestions,
  }) {
    List<String> filteredSuggestions = [];

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.9,
          minChildSize: 0.9,
          maxChildSize: 1.0,
          builder: (_, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
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

                      // Barre de recherche
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Recherchez une position...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            filteredSuggestions = suggestions
                                .where((item) =>
                                    item.toLowerCase().contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // Liste des suggestions
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: filteredSuggestions.isEmpty
                              ? suggestions.length
                              : filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            String location = filteredSuggestions.isEmpty
                                ? suggestions[index]
                                : filteredSuggestions[index];

                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(location),
                              onTap: () {
                                onLocationSelected(location);
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
}
