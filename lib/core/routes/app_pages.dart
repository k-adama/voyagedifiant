import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:voyagedifiant/views/controllers/auth/bindings/auth.bindings.dart';
import 'package:voyagedifiant/views/controllers/splash/bindings/splash_binding.dart';
import 'package:voyagedifiant/views/pages/auth/login/login_page.dart';
import 'package:voyagedifiant/views/pages/auth/register/register_page.dart';
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
      binding: SplashBinding(),
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
  ];
}
