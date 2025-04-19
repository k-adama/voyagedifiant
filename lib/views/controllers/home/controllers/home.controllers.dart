import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:voyagedifiant/core/models/driver_model.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
import 'package:voyagedifiant/core/models/vehicule.dart';
import 'package:voyagedifiant/core/repositories/Auth/home.repository.dart';
import 'package:voyagedifiant/core/services/app_connectivity.service.dart';

class HomeController extends GetxController {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  RxString selectedLieu = "Sélectionner un lieu".obs;
  bool isVehicleLoading = true;
  bool isTouristicSiteLoading = true;
  bool isHotelsLoading = true;
  bool hasConnection = true;
  final RxString searchQuery = ''.obs;
  final RxString searchVehiculeQuery = ''.obs;
  final RxString searchTouristicSiteQuery = ''.obs;
  List<VehicleModel> vehicles = List<VehicleModel>.empty().obs;
  List<VehicleModel> vehiculeInit = List<VehicleModel>.empty().obs;
  List<VehicleModel> displayedVehicles = List<VehicleModel>.empty().obs;

  List<TouristicDiscovery> touristicSites =
      List<TouristicDiscovery>.empty().obs;
  List<TouristicDiscovery> touristicSitesInit =
      List<TouristicDiscovery>.empty().obs;
  List<TouristicDiscovery> displayedTouristicSites =
      List<TouristicDiscovery>.empty().obs;

  List<HotelModel> hotels = List<HotelModel>.empty().obs;
  List<HotelModel> hotelsInit = List<HotelModel>.empty().obs;
  List<HotelModel> displayedHotels = List<HotelModel>.empty().obs;

  int currentPage = 0;
  final int itemsPerPage = 10;
  bool isLoadingMore = false;
  bool isLoadingMoreTouristicSite = false;
  bool isLoadingMoreHotels = false;

  var randomVehicle = Rx<VehicleModel?>(null);
  RxList<VehicleModel> randomVehicles = <VehicleModel>[].obs;
  RxList<TouristicDiscovery> randomTouristicSites = <TouristicDiscovery>[].obs;
  RxList<HotelModel> randomHotels = <HotelModel>[].obs;

  final homeRepository = HomeRepository();
  final DateFormat dateFormat = DateFormat('dd MMM');

  @override
  void onInit() {
    super.onInit();
    debounce<String>(
      searchVehiculeQuery,
      (value) {
        vehiculeSearchFilter(value);
      },
      time: const Duration(milliseconds: 300),
    );
    debounce<String>(
      searchTouristicSiteQuery,
      (value) {
        touristicSiteSearchFilter(value);
      },
      time: const Duration(milliseconds: 300),
    );
    debounce<String>(
      searchQuery,
      (value) {
        hotelSearchFilter(value);
      },
      time: const Duration(milliseconds: 300),
    );
  }

  @override
  void onReady() async {
    await Future.wait([
      fetchVehicles(),
      fetchTouristicSites(),
      fetchHotels(),
    ]);
    super.onReady();
  }

  Future<void> fetchVehicles() async {
    final connected = await AppConnectivityService.connectivity();
    if (!connected) {
      hasConnection = false;
      isVehicleLoading = false;
      update();
      Get.snackbar(
          "Erreur", 'Aucune connexion internet. Vérifiez votre réseau.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      hasConnection = true;
      isVehicleLoading = true;
      update();

      final result = await homeRepository.getVehicles();

      result.when(
        success: (data) {
          vehicles.assignAll(data);
          vehiculeInit.assignAll(data);
          displayedVehicles.clear();
          currentPage = 0;
          loadMore();
          if (vehicles.isNotEmpty) {
            // randomVehicle.value = vehicles[Random().nextInt(vehicles.length)];
            final shuffled = vehicles.toList()..shuffle();
            randomVehicles.assignAll(shuffled.take(20));
          }
        },
        failure: (message) {
          debugPrint("Erreur lors du chargement des véhicules : $message");
        },
      );

      isVehicleLoading = false;
      update();
    }
  }

  Future<void> fetchTouristicSites() async {
    final connected = await AppConnectivityService.connectivity();
    if (!connected) {
      hasConnection = false;
      isTouristicSiteLoading = false;
      update();
      Get.snackbar(
          "Erreur", 'Aucune connexion internet. Vérifiez votre réseau.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      hasConnection = true;
      isTouristicSiteLoading = true;
      update();

      final result = await homeRepository.getTouristicSites();
      result.when(
        success: (data) {
          touristicSites.assignAll(data);
          touristicSitesInit.assignAll(data);
          displayedTouristicSites.clear();
          currentPage = 0;
          loadMoreTouristicSites();
          if (touristicSites.isNotEmpty) {
            final shuffled = touristicSites.toList()..shuffle();
            randomTouristicSites.assignAll(shuffled.take(20));
          }
        },
        failure: (message) {
          // Gère le message d'erreur comme tu veux
          debugPrint("Erreur lors du chargement des véhicules : $message");
        },
      );

      isTouristicSiteLoading = false;
      update();
    }
  }

  Future<void> fetchHotels() async {
    final connected = await AppConnectivityService.connectivity();

    if (!connected) {
      hasConnection = false;
      isHotelsLoading = false;
      update();
      Get.snackbar(
          "Erreur", 'Aucune connexion internet. Vérifiez votre réseau.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      hasConnection = true;
      isHotelsLoading = true;
      update();

      try {
        final result = await homeRepository.getHotels();

        result.when(
          success: (data) {
            hotels.assignAll(data);
            hotelsInit.assignAll(data);
            displayedHotels.clear();
            currentPage = 0;
            loadMoreHotels();

            if (hotels.isNotEmpty) {
              final shuffled = hotels.toList()..shuffle();
              randomHotels.assignAll(shuffled.take(20));
            }
          },
          failure: (message) {
            debugPrint("Erreur lors du chargement des hôtels : $message");
            Get.snackbar("Erreur", message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          },
        );
      } catch (e) {
        debugPrint("Erreur inconnue lors du chargement des hôtels : $e");
        Get.snackbar("Erreur", 'Une erreur est survenue, veuillez réessayer.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      isHotelsLoading = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    update();

    await Future.delayed(const Duration(seconds: 1));

    final currentLength = displayedVehicles.length;
    final nextItems = vehicles.skip(currentLength).take(10).toList();
    displayedVehicles.addAll(nextItems);

    isLoadingMore = false;
    update();
  }

  Future<void> loadMoreTouristicSites() async {
    if (isLoadingMoreTouristicSite) return;

    isLoadingMoreTouristicSite = true;
    update();

    await Future.delayed(const Duration(seconds: 1));

    final currentLength = displayedTouristicSites.length;
    final nextItems = touristicSites.skip(currentLength).take(10).toList();
    displayedTouristicSites.addAll(nextItems);

    isLoadingMoreTouristicSite = false;
    update();
  }

  Future<void> loadMoreHotels() async {
    if (isLoadingMoreHotels) return;

    isLoadingMoreHotels = true;
    update();

    await Future.delayed(const Duration(seconds: 1));

    final currentLength = displayedHotels.length;
    final nextItems = hotels.skip(currentLength).take(10).toList();
    displayedHotels.addAll(nextItems);
    isLoadingMoreHotels = false;
    update();
  }

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

  void selectChauffeur(DriverModel chauffeur) {
    selectedChauffeur.value = chauffeur;
    Get.back();
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

  void vehiculeSearchFilter(String search) {
    if (vehiculeInit.isEmpty) return;

    if (search.trim().isEmpty) {
      displayedVehicles.clear();
      currentPage = 0;
      loadMore();
    } else {
      final searchText = search.toLowerCase();

      final filteredVehicules = vehiculeInit.where((item) {
        return item.name.toLowerCase().contains(searchText) ||
            item.economyPrice.toString().contains(searchText) ||
            //item.neighborhood.toLowerCase().contains(searchText) ||
            item.businessPrice.toString().contains(searchText);
      }).toList();

      displayedVehicles.assignAll(filteredVehicules);
    }

    update();
  }

  void touristicSiteSearchFilter(String search) {
    if (touristicSitesInit.isEmpty) return;

    if (search.trim().isEmpty) {
      displayedTouristicSites.clear();
      currentPage = 0;
      loadMoreTouristicSites();
    } else {
      final searchText = search.toLowerCase();

      final filteredTouristicSites = touristicSitesInit.where((item) {
        return item.name.toLowerCase().contains(searchText) ||
            item.location.toLowerCase().contains(searchText);
        // ||
        //  item.economyPrice.toString().contains(searchText) ||
        //item.neighborhood.toLowerCase().contains(searchText) ||
        // item.businessPrice.toString().contains(searchText);
      }).toList();

      displayedTouristicSites.assignAll(filteredTouristicSites);
    }

    update();
  }

  void hotelSearchFilter(String search) {
    if (hotelsInit.isEmpty) return;

    if (search.trim().isEmpty) {
      displayedHotels.clear();
      currentPage = 0;
      loadMoreHotels();
    } else {
      final searchText = search.toLowerCase();

      final filteredHotels = hotelsInit.where((item) {
        return item.name.toLowerCase().contains(searchText) ||
            item.city.toLowerCase().contains(searchText) ||
            //item.neighborhood.toLowerCase().contains(searchText) ||
            item.priceStandard.toString().contains(searchText) ||
            item.pricePremium.toString().contains(searchText) ||
            item.priceSuite.toString().contains(searchText);
      }).toList();

      displayedHotels.assignAll(filteredHotels);
    }

    update();
  }
}
