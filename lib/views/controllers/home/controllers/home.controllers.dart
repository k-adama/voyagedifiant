import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/constants/auth.constant.dart';
import 'package:voyagedifiant/core/models/VehiculeInvoiceModel.dart';
import 'package:voyagedifiant/core/models/discovery_invoice_model.dart';
import 'package:voyagedifiant/core/models/driver_model.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/models/hotel_invoice_model.dart';
import 'package:voyagedifiant/core/models/orders_model.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
import 'package:voyagedifiant/core/models/vehicule.dart';
import 'package:voyagedifiant/core/repositories/Auth/home.repository.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/services/app_connectivity.service.dart';
import 'package:voyagedifiant/core/services/local_storage.dart';
import 'package:voyagedifiant/core/widgets/dialogs/successfull.dialog.dart';
import 'package:voyagedifiant/views/pages/home/home_page.dart';
import 'package:voyagedifiant/views/pages/pdf/discovery_facture_pdf.dart';
import 'package:voyagedifiant/views/pages/pdf/hotel_facture_pdf.dart';
import 'package:voyagedifiant/views/pages/pdf/vehicle_invoice_pdf.dart';

class HomeController extends GetxController {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  RxString selectedLieu = "Sélectionner un lieu".obs;
  bool isVehicleLoading = true;
  bool isTouristicSiteLoading = true;
  bool isHotelsLoading = true;
  bool isSejourLoading = false;
  bool hasConnection = true;
  var isPaaswordChangeLoading = false.obs;
  var isProfilChangeLoading = false.obs;
  var isUserVehicleOrdersLoading = false.obs;
  var isUserDiscoveryOrdersLoading = false.obs;

  var page = 1.obs;
  var isVehicleOrdersLoading = false.obs;
  var hasMore = true.obs;
  final Rx<DriverModel?> selectedChauffeur = Rx<DriverModel?>(null);

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

  List<OrderModel> orders = List<OrderModel>.empty().obs;
  List<OrderModel> ordersInit = List<OrderModel>.empty().obs;

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
      getAllOrders(),
    ]);
    super.onReady();
  }

  Future<void> getAllOrders({bool isRefresh = false}) async {
    if (isVehicleOrdersLoading.value) return;

    if (isRefresh) {
      page.value = 1;
      hasMore.value = true;
      orders.clear();
    }

    if (!hasMore.value) return;

    isVehicleOrdersLoading.value = true;

    final result = await homeRepository.getUserOrders(page: page.value);

    result.when(
      success: (data) {
        if (data.length < 10) {
          hasMore.value = false; // plus de pages
        }
        orders.addAll(data);
        page.value++;
      },
      failure: (message) {
        Get.snackbar("Erreur", message, snackPosition: SnackPosition.TOP);
      },
    );

    isVehicleOrdersLoading.value = false;
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
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      helpText: 'Choisissez une date',
      locale: const Locale('fr'),
    );

    if (pickedDate != null) {
      startDate = pickedDate;
      endDate = null;
      update();

      await selectTime(isStartTime: true);

      // Demander s'il veut ajouter une date de fin
      final bool wantsRange = await showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: const Text('Ajouter une date de fin ?'),
          content: const Text("Souhaitez-vous ajouter une date de fin ?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(_, false),
                child: const Text("Non")),
            ElevatedButton(
                onPressed: () => Navigator.pop(_, true),
                child: const Text("Oui")),
          ],
        ),
      );

      if (wantsRange == true) {
        final pickedEndDate = await showDatePicker(
          context: Get.context!,
          initialDate: pickedDate,
          firstDate: pickedDate,
          lastDate: DateTime(DateTime.now().year + 1),
          helpText: 'Choisissez une date de fin',
          locale: const Locale('fr'),
        );

        if (pickedEndDate != null) {
          endDate = pickedEndDate;
          await selectTime(isStartTime: false);
        }
      } else {
        update();
      }

      update();
    }
  }

  /*Future<void> selectDateRange() async {
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
  }*/

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

  String get displayLocationPeriodText {
    if (startDate == null || startTime == null) {
      return 'Sélectionner une période';
    }

    final String formattedStart =
        '${dateFormat.format(startDate!)} à ${startTime!.format(Get.context!)}';

    if (endDate != null && endTime != null) {
      final String formattedEnd =
          '${dateFormat.format(endDate!)} à ${endTime!.format(Get.context!)}';
      return 'Du $formattedStart → $formattedEnd';
    }

    return 'Le $formattedStart';
  }

  /* String get displayLocationPeriodText {
    if (startDate == null ||
        endDate == null ||
        startTime == null ||
        endTime == null) {
      return 'Sélectionner une période';
    }
    return '${dateFormat.format(startDate!)} ${startTime!.format(Get.context!)} → '
        '${dateFormat.format(endDate!)} ${endTime!.format(Get.context!)}';
  }*/

  // Chauffeur sélectionné
  /* var selectedChauffeur = Rx<DriverModel>(DriverModel(
    imageUrl: 'assets/icons/utilisateur.png',
    name: 'Chara',
    phoneNumber: 'xx00000000',
    rating: 4.5,
  ));*/

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
    update();
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

  void goToVehiculeInvoicePage(VehicleModel? vehicle, String? selectedClass) {
    /*  if (startDate == null || endDate == null) {
      Get.snackbar(
        'Période requise',
        'Veuillez choisir une période de location',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }*/
    if (startDate == null || startTime == null) {
      Get.snackbar(
        'Période requise',
        'Veuillez choisir au moins une date et une heure de début',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedClass == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner une classe',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    final String price = selectedClass == 'Economie'
        ? vehicle?.economyPrice.toString() ?? '0'
        : selectedClass == 'Business'
            ? vehicle?.businessPrice.toString() ?? '0'
            : '0';

    //final double numberOfDays = endDate!.difference(startDate!).inDays + 1;
    final double numberOfDays =
        endDate != null ? endDate!.difference(startDate!).inDays + 1 : 1;
    final double dailyPrice = double.tryParse(price) ?? 0;
    final double totalPrice = dailyPrice * numberOfDays;

    final invoice = VehiculeInvoiceModel(
      name: vehicle?.name ?? '',
      bag: vehicle?.luggage.toString() ?? '',
      person: vehicle?.numberOfSeats.toString() ?? '',
      airConditioning: (vehicle?.airConditioning ?? false) ? '1' : '0',
      classe: selectedClass,
      locationVehiclePeriod: displayLocationPeriodText,
      driver: selectedChauffeur.value!.name,
      price: price,
      totalPrice: totalPrice,
      totalPriceOperation:
          '${dailyPrice.toStringAsFixed(0)} * $numberOfDays = ${totalPrice.toStringAsFixed(0)} FCFA',
    );

    Get.toNamed(Routes.INVOICE_PAGE, arguments: invoice.toJson());
  }

  Future<void> saveInvoiceToDatabase(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> dataToSend = {
      'vehicle_name': data['name']?.toString() ?? '',
      'bags': data['bag']?.toString() ?? '',
      'passengers': data['person']?.toString() ?? '',
      'air_conditioning': data['airConditioning']?.toString() ?? '',
      'vehicle_class': data['class']?.toString() ?? '',
      'rental_period': data['locationVehiclePeriod']?.toString() ?? '',
      'driver': data['driver']?.toString() ?? '',
      'price': data['price']?.toString() ?? '',
      'total_price': data['totalPrice']?.toString() ?? '',
      'username': data['username']?.toString() ?? '',
      'phone': data['phone']?.toString() ?? '',
      'amount_paid': data['montantApaye']?.toString() ?? '',
    };

    try {
      isUserVehicleOrdersLoading.value = true;
      await homeRepository.createReservation(dataToSend);
      getAllOrders(isRefresh: true);
      startDate = null;
      endDate = null;

      AppHelpersCommon.showAlertDialog(
        context: context,
        canPop: false,
        child: SuccessfullDialog(
            isCustomerAdded: false,
            haveButton: false,
            svgPicture: "assets/icons/undraw_happy_news_re_tsbd 1.svg",
            content: 'Réservation enregistrée',
            redirect: () async {
              Get.offAllNamed('/home_page');
            }),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isUserVehicleOrdersLoading.value = false;
    }
  }

  void goToTouristicSiteInvoicePage(
      TouristicDiscovery? touristicSite, String? selectedClass) {
    if (startDate == null || startTime == null) {
      Get.snackbar(
        'Période requise',
        'Veuillez choisir au moins une date et une heure de début',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedClass == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner une classe',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    if (!lieuxDeRassemblement.contains(selectedLieu.value)) {
      Get.snackbar('Erreur', 'Veuillez sélectionner un lieu de rassemblement',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    String price = '0';

    if (selectedClass == 'Standard') {
      price = touristicSite?.standardPrice.toString() ?? '0';
    } else if (selectedClass == 'Premium') {
      price = touristicSite?.premiumPrice.toString() ?? '0';
    } else if (selectedClass == 'Suite') {
      price = touristicSite?.suitePrice.toString() ?? '0';
    }

    //final int numberOfDays = endDate!.difference(startDate!).inDays + 1;
    final int numberOfDays =
        endDate != null ? endDate!.difference(startDate!).inDays + 1 : 1;
    final int dailyPrice = int.tryParse(price) ?? 0;
    final int totalPrice = dailyPrice * numberOfDays;
    final String lieuDeRassemblement = selectedLieu.value;

    final discoveryInvoice = DiscoveryInvoiceModel(
      name: touristicSite!.name,
      classe: selectedClass,
      lieuDeRassemblement: lieuDeRassemblement,
      reservationPeriod: displayLocationPeriodText,
      price: price,
      totalPrice: totalPrice,
      totalPriceOperation:
          '${dailyPrice.toStringAsFixed(0)} * $numberOfDays = ${totalPrice.toStringAsFixed(0)} FCFA',
    );
    Get.toNamed(Routes.INVOICE_DECOUVERTE_PAGE,
        arguments: discoveryInvoice.toJson());
  }

  Future<void> saveDiscoveryInvoiceToDatabase(
      BuildContext context, Map<String, dynamic> discoveryData) async {
    final Map<String, dynamic> discoveryDatatoSend = {
      'site_name': discoveryData['name']?.toString() ?? '',
      'classe': discoveryData['class']?.toString() ?? '',
      'lieu_de_rassemblement':
          discoveryData['lieuDeRassemblement']?.toString() ?? '',
      'reservation_period':
          discoveryData['reservationPeriod']?.toString() ?? '',
      'price': discoveryData['price']?.toString() ?? '',
      'total_price': discoveryData['totalPrice']?.toString() ?? '',
      'username': discoveryData['username']?.toString() ?? '',
      'phone': discoveryData['phone']?.toString() ?? '',
      'amount_paid': discoveryData['montantApaye']?.toString() ?? '',
    };

    try {
      isUserDiscoveryOrdersLoading.value = true;
      await homeRepository.createDiscoveryReservation(discoveryDatatoSend);
      getAllOrders(isRefresh: true);
      startDate = null;
      endDate = null;
      AppHelpersCommon.showAlertDialog(
        context: context,
        canPop: false,
        child: SuccessfullDialog(
          isCustomerAdded: false,
          haveButton: false,
          svgPicture: "assets/icons/undraw_happy_news_re_tsbd 1.svg",
          content: 'Réservation enregistrée',
          redirect: () async => Get.offAllNamed('/home_page'),
        ),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isUserDiscoveryOrdersLoading.value = false;
    }
  }

  void goToHotelInvoicePage(HotelModel? hotel, String? selectedClass) {
    if (startDate == null || startTime == null) {
      Get.snackbar(
        'Période requise',
        'Veuillez choisir au moins une date et une heure de début',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedClass == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner une classe',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    /* if (!lieuxDeRassemblement.contains(selectedLieu.value)) {
      Get.snackbar('Erreur', 'Veuillez sélectionner un lieu de prise en charge',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }*/

    String price = '0';

    if (selectedClass == 'Standard') {
      price = hotel?.priceStandard.toString() ?? '0';
    } else if (selectedClass == 'Premium') {
      price = hotel?.pricePremium.toString() ?? '0';
    } else if (selectedClass == 'Suite') {
      price = hotel?.priceSuite.toString() ?? '0';
    }

    //final int numberOfDays = endDate!.difference(startDate!).inDays + 1;
    final int numberOfDays =
        endDate != null ? endDate!.difference(startDate!).inDays + 1 : 1;
    final int dailyPrice = int.tryParse(price) ?? 0;
    final int totalPrice = dailyPrice * numberOfDays;
    // final String lieuDeRassemblement = selectedLieu.value;

    final hotelInvoice = HotelInvoiceModel(
      hotelName: hotel!.name,
      classe: selectedClass,
      driverName: selectedChauffeur.value!.name,
      neighborhood: hotel.neighborhood,
      city: hotel.city,
      descriptionEn: hotel.descriptionEn,
      descriptionFr: hotel.descriptionFr,
      // lieuDeRassemblement: lieuDeRassemblement,
      rentalPeriod: displayLocationPeriodText,
      price: price,
      totalPrice: totalPrice,
      totalPriceOperation:
          '${dailyPrice.toStringAsFixed(0)} * $numberOfDays = ${totalPrice.toStringAsFixed(0)} FCFA',
    );
    Get.toNamed(Routes.INVOICE_SEJOUR_PAGE, arguments: hotelInvoice.toJson());
  }

  Future<void> saveHotelInvoiceToDatabase(
      BuildContext context, Map<String, dynamic> hotelData) async {
    final Map<String, dynamic> hotelDatatoSend = {
      'hotel_name': hotelData['hotel_name']?.toString() ?? '',
      'driver_name': hotelData['driver']?.toString() ?? '',
      'city': hotelData['neighborhood']?.toString() ?? '',
      'reservation_period': hotelData['rental_period']?.toString() ?? '',
      'classe': hotelData['class']?.toString() ?? '',
      //'lieu_de_rassemblement':
      //    hotelData['lieuDeRassemblement']?.toString() ?? '',

      'price': hotelData['price']?.toString() ?? '',
      'total_price': hotelData['total_price']?.toString() ?? '',
      'amount_paid': hotelData['montantApaye']?.toString() ?? '',
      'username': hotelData['username']?.toString() ?? '',
      'phone': hotelData['phone']?.toString() ?? '',
    };
    try {
      await homeRepository.createHotelReservation(hotelDatatoSend);
      getAllOrders(isRefresh: true);
      startDate = null;
      endDate = null;
      AppHelpersCommon.showAlertDialog(
        context: context,
        canPop: false,
        child: SuccessfullDialog(
          isCustomerAdded: false,
          haveButton: false,
          svgPicture: "assets/icons/undraw_happy_news_re_tsbd 1.svg",
          content: 'Réservation enregistrée',
          redirect: () async => Get.offAllNamed('/home_page'),
        ),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’enregistrement : $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void onSendInvoiceButtonPressed(Map<String, dynamic> invoiceData) async {
    try {
      final pdfFile = await generateHotelInvoicePdf(invoiceData);
      final pdfBytes = await pdfFile.readAsBytes();

      await homeRepository.sendHotelInvoicePdf(
        pdfBytes: pdfBytes,
        email: invoiceData['email'],
      );

      Get.snackbar(
          'Facture', 'Facture envoyée par mail, vérifiez vos mails svp !',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’envoi de la facture : $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void onSendDiscoveryInvoice(Map<String, dynamic> invoiceData) async {
    try {
      final pdfFile = await generateDiscoveryInvoicePdf(invoiceData);
      final pdfBytes = await pdfFile.readAsBytes();

      await homeRepository.sendHotelInvoicePdf(
        pdfBytes: pdfBytes,
        email: invoiceData['email'],
      );

      Get.snackbar(
          'Facture', 'Facture envoyée par mail, vérifiez vos mails svp !',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’envoi de la facture : $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void onSendVehicleInvoice(Map<String, dynamic> invoiceData) async {
    try {
      final pdfFile = await generateVehicleInvoicePdf(invoiceData);
      final pdfBytes = await pdfFile.readAsBytes();

      await homeRepository.sendHotelInvoicePdf(
        pdfBytes: pdfBytes,
        email: invoiceData['email'],
      );

      Get.snackbar(
          'Facture', 'Facture envoyée par mail, vérifiez vos mails svp !',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de l’envoi de la facture : $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      isProfilChangeLoading.value = true;
      final updatedUser = await homeRepository.updateUserProfile(data);

      await LocalStorage.instance.set(
        AuthConstant.keyUser,
        jsonEncode(updatedUser.toJson()),
      );

      Get.snackbar("Succès", "Profil mis à jour avec succès",
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Erreur", "Échec de la mise à jour",
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      isProfilChangeLoading.value = false;
    }
  }

  Future<void> changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    try {
      isPaaswordChangeLoading.value = true;

      await homeRepository.changePassword({
        'current_password': oldPassword,
        'new_password': newPassword,
      });

      AppHelpersCommon.showAlertDialog(
        context: context,
        canPop: false,
        child: SuccessfullDialog(
            isCustomerAdded: false,
            haveButton: false,
            svgPicture: "assets/icons/undraw_happy_news_re_tsbd 1.svg",
            content: 'Mot de passe modifié avec succès',
            redirect: () async {
              LocalStorage.instance.removeToken();
              LocalStorage.instance.removeBool("otp_verified");
              LocalStorage.instance.removeUserId("userId");
              Get.offAllNamed(Routes.LOGIN_PAGE);
            }),
      );
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? "Une erreur est survenue";
      Get.snackbar("Erreur", errorMessage,
          colorText: Colors.white, backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar("Erreur", "Échec de la modification : ${e.toString()}");
    } finally {
      isPaaswordChangeLoading.value = false;
    }
  }

  /*void goToVehiculeInvoicePage(VehicleModel? vehicle, String? selectedClass) {
    if (startDate == null || endDate == null) {
      Get.snackbar(
          'Période requise', 'Veuillez choisir une période de location',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    String? className = selectedClass;
    String name = vehicle?.name ?? '';
    String price = '';
    String person = vehicle?.numberOfSeats.toString() ?? '';
    String bag = vehicle?.luggage.toString() ?? '';
    String airConditioning = (vehicle?.airConditioning ?? false) ? '1' : '0';
    String locationVehiclePeriod = displayLocationPeriodText;
    String driver = selectedChauffeur.value.name;

    if (className == 'Economie') {
      price = vehicle?.economyPrice.toString() ?? '';
    } else if (className == 'Business') {
      price = vehicle?.businessPrice.toString() ?? '';
    } else {
      Get.snackbar('Erreur', 'Veuillez sélectionner une classe',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    int numberOfDays = endDate!.difference(startDate!).inDays + 1;
    double dailyPrice = double.tryParse(price) ?? 0.0;
    double totalPrice = dailyPrice * numberOfDays;
    String totalPriceFormatted =
        '${dailyPrice.toStringAsFixed(0)} * $numberOfDays = ${totalPrice.toStringAsFixed(0)} FCFA';
    print('...............');
    print(name);
    print(className);
    print(price);
    print(locationVehiclePeriod);
    print(driver);
    print(totalPrice);
    Get.toNamed(Routes.INVOICE_PAGE, arguments: {
      'name': name,
      'class': className,
      'price': price,
      'bag': bag,
      'person': person,
      'airConditioning': airConditioning,
      'locationVehiclePeriod': locationVehiclePeriod,
      'driver': driver,
      'totalPrice': totalPrice,
      'totalPriceOperation': totalPriceFormatted,

      //'$price * $numberOfDays ${numberOfDays > 1 ? '' : ''} = ${totalPrice.toStringAsFixed(0)} FCFA',
    });
  }*/
}
