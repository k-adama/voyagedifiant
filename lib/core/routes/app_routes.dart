part of './app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const HOME_PAGE = _Paths.HOME_PAGE;
  static const VEHICULE_ITEM_PAGE = _Paths.VEHICULE_ITEM_PAGE;
  static const VEHICULE_DETAILS = _Paths.VEHICULE_DETAILS;
  static const LOGIN_PAGE = _Paths.LOGIN_PAGE;
  static const REGISTER_PAGE = _Paths.REGISTER_PAGE;
  static const NUMBER_VERIFICATION_PAGE = _Paths.NUMBER_VERIFICATION_PAGE;
  static const HISTORIE_PAGE = _Paths.HISTORIE_PAGE;
  static const FAQS_PAGE = _Paths.FAQS_PAGE;
  static const PROFIL_PASSWORD_CHANGE = _Paths.PROFIL_PASSWORD_CHANGE;
  static const INVOICE_PAGE = _Paths.INVOICE_PAGE;
  static const PASSWORD_FORGOT_PAGE = _Paths.PASSWORD_FORGOT_PAGE;
  static const PASSWORD_FORGOT_OTP = _Paths.PASSWORD_FORGOT_OTP;
  static const NEW_PASSWORD_PAGE = _Paths.NEW_PASSWORD_PAGE;
  static const PROFILE_INFO = _Paths.PROFILE_INFO;
  static const THEME_CONFIDENTIALITE = _Paths.THEME_CONFIDENTIALITE;
  static const DETAILS_FAQS = _Paths.DETAILS_FAQS;
  static const MONEY = _Paths.MONEY;

  static const SEJOUR_ITEM_PAGE = _Paths.SEJOUR_ITEM_PAGE;
  static const SEJOUR_DETAILS = _Paths.SEJOUR_DETAILS;
  static const INVOICE_SEJOUR_PAGE = _Paths.INVOICE_SEJOUR_PAGE;
  static const ALL_DECOUVERTE_ITEMS = _Paths.ALL_DECOUVERTE_ITEMS;
  static const DECOUVERTE_DETAILS = _Paths.DECOUVERTE_DETAILS;
  static const INVOICE_DECOUVERTE_PAGE = _Paths.INVOICE_DECOUVERTE_PAGE;
  static const CONTACT_PAGE = _Paths.CONTACT_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = "/splash";
  static const HOME_PAGE = "/home_page";
  static const VEHICULE_ITEM_PAGE = "/vehicule_item_page";
  static const VEHICULE_DETAILS = "/vehicule_details";
  static const LOGIN_PAGE = "/login_page";
  static const REGISTER_PAGE = "/register_page";
  static const NUMBER_VERIFICATION_PAGE = "/number_verification_page";
  static const HISTORIE_PAGE = "/historie_page";
  static const FAQS_PAGE = "/faqs_page";
  static const PROFIL_PASSWORD_CHANGE = "/profil_password_change";
  static const INVOICE_PAGE = "/invoice_page";
  static const PASSWORD_FORGOT_PAGE = "/password_forgot_page";
  static const PASSWORD_FORGOT_OTP = "/password_forgot_otp";
  static const NEW_PASSWORD_PAGE = "/new_password_page";
  static const PROFILE_INFO = "/profile_info";
  static const THEME_CONFIDENTIALITE = "/theme_confidentialite";
  static const DETAILS_FAQS = "/details_faqs";
  static const MONEY = "/money";

  static const SEJOUR_ITEM_PAGE = "/sejour_item_page";
  static const SEJOUR_DETAILS = "/sejour_details";
  static const INVOICE_SEJOUR_PAGE = "/invoice_sejour_page";
  static const ALL_DECOUVERTE_ITEMS = "/all_decouverte_items";
  static const DECOUVERTE_DETAILS = "/decouverte_details";
  static const INVOICE_DECOUVERTE_PAGE = "/invoice_decouverte_page";
  static const CONTACT_PAGE = "/contact_page";
}
