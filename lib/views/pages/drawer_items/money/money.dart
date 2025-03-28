import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

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
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.language_outlined)
            )
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("MONEY",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               SizedBox(height: Get.height/15,),
                Text("Sélectionnez votre type de monnaie ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
               RadioListTile<String>(
            title: Text("Monnaie des états de l’Afrique de l’Ouest (XOF)"),
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