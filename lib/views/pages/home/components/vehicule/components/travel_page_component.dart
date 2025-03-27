import 'package:flutter/material.dart';

class TravelPageComponent extends StatefulWidget {
  const TravelPageComponent({super.key});

  @override
  State<TravelPageComponent> createState() => _TravelPageComponentState();
}

class _TravelPageComponentState extends State<TravelPageComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          children: [
            Icon(Icons.directions_car, size: 20),
            SizedBox(
              height: 20, // Hauteur de la barre verticale
              child: VerticalDivider(color: Colors.black),
            ),
            Icon(Icons.directions_car, size: 20),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[100],
                  child: Text('currentLocation'),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.green[100],
                  child: Text('destination'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
