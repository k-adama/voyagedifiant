part of './app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const HOME_PAGE = _Paths.HOME_PAGE;
  static const LOGIN_PAGE = _Paths.LOGIN_PAGE;
  static const REGISTER_PAGE = _Paths.REGISTER_PAGE;
  static const NUMBER_VERIFICATION_PAGE = _Paths.NUMBER_VERIFICATION_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = "/splash";
  static const HOME_PAGE = "/home_page";
  static const LOGIN_PAGE = "/login_page";
  static const REGISTER_PAGE = "/register_page";
  static const NUMBER_VERIFICATION_PAGE = "/number_verification_page";
}
