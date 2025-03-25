import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/views/controllers/Main/bindings/main.binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return RefreshConfiguration(
            footerBuilder: () => const ClassicFooter(
              idleIcon: SizedBox(),
              idleText: "",
              noDataText: "",
            ),
            headerBuilder: () => const WaterDropMaterialHeader(
              backgroundColor: AppColors.white,
              color: AppColors.textGrey,
            ),
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Voyagedifiant",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              initialBinding: MainBinding(),
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('fr', 'FR'),
              ],
              locale: const Locale('fr'),
              theme: ThemeData(
                fontFamily: 'Cereal',
                useMaterial3: false,
                sliderTheme: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    rangeThumbShape: RoundRangeSliderThumbShape()),
              ),
              themeMode: ThemeMode.light,
            ),
          );
        });
  }
}
