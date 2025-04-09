import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:voyagedifiant/core/models/driver_model.dart';

class HomeController extends GetxController {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  RxString selectedLieu = "Sélectionner un lieu".obs;

  // Format des dates
  final DateFormat dateFormat = DateFormat('dd MMM');

  Future<void> selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
      helpText: 'Début - Fin',
      saveText: 'Enregistrer',
      locale: const Locale('fr'),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.red,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate = picked.start;
      endDate = picked.end;
      update();

      await selectTime(isStartTime: true);
      await selectTime(isStartTime: false);
    }
  }

  // Sélection d'une heure avec un titre personnalisé
  Future<void> selectTime({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: isStartTime
          ? (startTime ?? TimeOfDay.now())
          : (endTime ?? TimeOfDay.now()),
      helpText: isStartTime
          ? 'Sélectionnez l\'heure de prise en charge'
          : 'Sélectionnez l\'heure de retour',
    );

    if (pickedTime != null) {
      if (isStartTime) {
        startTime = pickedTime;
      } else {
        endTime = pickedTime;
      }
      update();
    }
  }

  // Affichage du texte résumé
  String get displayText {
    if (startDate == null ||
        endDate == null ||
        startTime == null ||
        endTime == null) {
      return 'Sélectionner une période';
    }
    return '${dateFormat.format(startDate!)} ${startTime!.format(Get.context!)} → '
        '${dateFormat.format(endDate!)} ${endTime!.format(Get.context!)}';
  }

  // Chauffeur sélectionné
  var selectedChauffeur = Rx<DriverModel>(DriverModel(
    imageUrl: 'assets/icons/utilisateur.png',
    name: 'Chara',
    phoneNumber: 'xx00000000',
    rating: 4.5,
  ));

  // Liste des chauffeurs disponibles
  final List<DriverModel> chauffeurs = [
    DriverModel(
      imageUrl: 'assets/icons/utilisateur.png',
      name: 'Chara 1',
      phoneNumber: 'xx00000000',
      rating: 4.5,
    ),
    DriverModel(
      imageUrl: 'assets/icons/utilisateur.png',
      name: 'Chara 2',
      phoneNumber: 'xx00000000',
      rating: 4.8,
    ),
    DriverModel(
      imageUrl: 'assets/icons/utilisateur.png',
      name: 'Chara pro',
      phoneNumber: 'xx00000000',
      rating: 4.2,
    ),
  ];

  // Met à jour le chauffeur sélectionné
  void selectChauffeur(DriverModel chauffeur) {
    selectedChauffeur.value = chauffeur;
    Get.back(); // Ferme le BottomSheet
  }

  final List<String> lieuxDeRassemblement = [
    "Abidjan",
    "Yamoussoukro",
    "Bouaké",
    "San-Pédro",
    "Daloa",
    "Korhogo",
    "Man",
    "Gagnoa",
    "Divo",
    "Abengourou",
    "Odienné",
    "Bondoukou",
    "Séguéla",
    "Touba",
    "Aboisso",
    "Ferkessédougou",
    "Bingerville",
    "Soubré",
    "Guiglo",
    "Sassandra",
    "Daoukro",
    "Agboville",
    "Adzopé",
    "Tiassalé",
    "Danané",
    "Jacqueville",
    "Grand-Bassam",
    "Tabou",
    "Issia",
    "Vavoua",
    "Tanda",
    "Boundiali",
    "Akoupé",
    "Katiola",
    "Mankono",
    "Tiapoum",
    "Toumodi",
    "Zuenoula",
    "Arrah",
    "Oumé",
  ];
}
