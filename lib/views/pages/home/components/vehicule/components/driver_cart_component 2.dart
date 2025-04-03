import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/models/driver_model.dart';

class DriverCardComponent extends StatelessWidget {
  final DriverModel driver;
  final VoidCallback onChange;

  const DriverCardComponent({
    super.key,
    required this.driver,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          // Image du chauffeur
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(driver.imageUrl),
          ),
          const SizedBox(width: 12),

          // Infos du chauffeur (Nom, numéro, note)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  driver.phoneNumber,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                RatingBarIndicator(
                  rating: driver.rating,
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
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Changer'),
          ),
        ],
      ),
    );
  }
}
