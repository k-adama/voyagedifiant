import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/models/driver_model.dart';

class DriverCardComponent extends StatelessWidget {
  final DriverModel? driver;
  final VoidCallback onChange;
  final bool isNotSejour;

  const DriverCardComponent({
    super.key,
    required this.driver,
    required this.onChange,
    this.isNotSejour = true,
  });

  @override
  Widget build(BuildContext context) {
    if (driver == null) {
      // Aucun chauffeur sélectionné : on affiche un conteneur cliquable
      return GestureDetector(
        onTap: onChange,
        child: Container(
          padding: isNotSejour == true
              ? const EdgeInsets.only(left: 12, right: 12)
              : null,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/icons/utilisateur.png",
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Sélectionner un chauffeur",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: onChange,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDefaults.borderRadius,
                  ),
                ),
                child: const Text('Changer'),
              ),
            ],
          ),
        ),
      );
    }

    // Chauffeur sélectionné : on affiche la carte normale
    return Container(
      padding: isNotSejour == true
          ? const EdgeInsets.only(left: 12, right: 12)
          : null,
      child: Row(
        children: [
          CircleAvatar(
             radius: 15,
            backgroundImage: AssetImage(driver!.imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver!.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  driver!.phoneNumber,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                RatingBarIndicator(
                  rating: driver!.rating,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onChange,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: AppDefaults.borderRadius,
              ),
            ),
            child: const Text('Changer'),
          ),
        ],
      ),
    );
  }
}

/*class DriverCardComponent extends StatelessWidget {
  final DriverModel? driver;
  final VoidCallback onChange;
  final bool isNotSejour;

  const DriverCardComponent({
    super.key,
    required this.driver,
    required this.onChange,
    this.isNotSejour = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isNotSejour == true
          ? const EdgeInsets.only(left: 12, right: 12)
          : null,
      child: Row(
        children: [
          // Image du chauffeur
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(driver!.imageUrl),
          ),
          const SizedBox(width: 12),

          // Infos du chauffeur (Nom, numéro, note)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver!.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  driver!.phoneNumber,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                RatingBarIndicator(
                  rating: driver!.rating,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),

          // Bouton "Changer"
          ElevatedButton(
            onPressed: onChange,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: AppDefaults.borderRadius,
              ),
            ),
            child: const Text('Changer'),
          ),
        ],
      ),
    );
  }
}
*/