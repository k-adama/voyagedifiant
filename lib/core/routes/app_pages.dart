import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:voyagedifiant/views/controllers/auth/bindings/auth.bindings.dart';
import 'package:voyagedifiant/views/controllers/home/bindings/home.bindings.dart';
import 'package:voyagedifiant/views/controllers/splash/bindings/splash_binding.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/password_forgot/new_password_page.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/password_forgot/password_forgot_otp.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/password_forgot/password_forgot_page.dart';
import 'package:voyagedifiant/views/pages/auth/login/login_page.dart';
import 'package:voyagedifiant/views/pages/auth/number_verification.dart';
import 'package:voyagedifiant/views/pages/auth/register/register_page.dart';
import 'package:voyagedifiant/views/pages/drawer_items/confidentialite/theme_confidentialite.dart';
import 'package:voyagedifiant/views/pages/drawer_items/faqs/details_faqs.dart';
import 'package:voyagedifiant/views/pages/drawer_items/faqs/faqs_page.dart';
import 'package:voyagedifiant/views/pages/drawer_items/money/money.dart';
import 'package:voyagedifiant/views/pages/drawer_items/orders/orders_historie_page.dart';
import 'package:voyagedifiant/views/pages/drawer_items/profile/password_change_page.dart';
import 'package:voyagedifiant/views/pages/drawer_items/profile/profile_info_page.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/all_decouverte.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/components/decouverte_details.dart';
import 'package:voyagedifiant/views/pages/home/components/decouverte/invoice_decouverte_page.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/all_sejour.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/invoice_sejour.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/sejour_details_component.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/all_vehicule_item.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/invoice_page.dart';
import 'package:voyagedifiant/views/pages/home/components/vehicule/vehicule_details.dart';
import 'package:voyagedifiant/views/pages/splash/splash_view.dart';
import 'package:voyagedifiant/views/pages/home/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  AppPages._();
  static const INITIAL = _Paths.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VEHICULE_ITEM_PAGE,
      page: () => const AllVehiculeItems(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VEHICULE_DETAILS,
      page: () => const VehiculeDetails(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_PAGE,
      page: () => const InvoicePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NUMBER_VERIFICATION_PAGE,
      page: () => const NumberVerificationPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HISTORIE_PAGE,
      page: () => const OrdersHistoriePage(),
      binding: AuthBinding(),
    ),
     GetPage(
      name: _Paths.FAQS_PAGE,
      page: () => const FaqsPage(),
      binding: AuthBinding(),
    ),
     GetPage(
      name: _Paths.PROFIL_PASSWORD_CHANGE,
      page: () => const PasswordChangePage(),
      binding: AuthBinding(),
     ),
    GetPage(
      name: _Paths.PASSWORD_FORGOT_PAGE,
      page: () => const PasswordForgotPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_FORGOT_OTP,
      page: () => const PasswordForgotPageOtp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD_PAGE,
      page: () => const NewPasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_INFO,
      page: () => const ProfileInfoPage(),
      binding: AuthBinding(),
    ),
     GetPage(
      name: _Paths.THEME_CONFIDENTIALITE,
      page: () => const ThemeConfidentialitePage(),
      binding: AuthBinding(),
    ),
     GetPage(
      name: _Paths.DETAILS_FAQS,
      page: () => const DetailsFaqsPage(),
      binding: AuthBinding(),
    ),
     GetPage(
      name: _Paths.MONEY,
      page: () => const MoneyPage(),
      binding: AuthBinding(),
    ),
    
    GetPage(
      name: _Paths.SEJOUR_ITEM_PAGE,
      page: () => const AllSejourItems(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEJOUR_DETAILS,
      page: () => const SejourDetails(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: _Paths.INVOICE_SEJOUR_PAGE,
      page: () => const InvoiceSejourPage(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: _Paths.ALL_DECOUVERTE_ITEMS,
      page: () => const AllDecouverteItems(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: _Paths.DECOUVERTE_DETAILS,
      page: () => const DecouverteDetails(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: _Paths.INVOICE_DECOUVERTE_PAGE,
      page: () => const InvoiceDecouvertePage(),
      binding: HomeBinding(),
    ),
  ];
}
