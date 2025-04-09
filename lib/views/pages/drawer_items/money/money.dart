import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Supprime l'ombre
        actions: const [
          TranslatePopItem(
            isDrawer: true,
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MONNAIE",
                style: AppColors.interBold(
                  size: 18,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Sélectionnez votre type de monnaie ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            RadioListTile<String>(
              title:
                  const Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 1",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 2",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 3",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 4",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 5",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
              value: "Option 6",
              activeColor: AppColors.signUpColor,
              groupValue: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
          ],
        ),
      )),
    );
  }
}
