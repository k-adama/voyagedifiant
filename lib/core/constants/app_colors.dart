import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  AppColors._();
  /* <----------- Colors ------------> */
  /// Primary Color of this App
  static const Color primary = Color(0xFF00AD48);

  // Others Color
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  /// used for page with box background
  static const Color scaffoldWithBoxBackground = Color(0xFFF7F7F7);
  static const Color cardColor = Color(0xFFF2F2F2);
  static const Color coloredBackground = Color(0xFFE4F8EA);
  static const Color placeholder = Color(0xFF8B8B97);
  static const Color textInputBackground = Color(0xFFF7F7F7);
  static const Color separator = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFFE1E1E1);
  static const Color textGrey = Color(0xFF898989);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF020548);
  static const Color underLineColor = Color(0xFF0544A8);
  static const Color black = Color(0xFF000000);
  static const Color outlinedColor = Color(0xFFDADADA);
  static const Color signUpColor = Color(0xFFF60FC0);

  static interBold(
          {double size = 20,
          Color color = AppColors.black,
          bool isUnderLine = false,
          Color underLineColor = AppColors.underLineColor,
          double letterSpacing = 0}) =>
      TextStyle(
          fontFamily: 'Cereal',
          fontSize: size.sp,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: letterSpacing.sp,
          decorationColor: isUnderLine ? underLineColor : AppColors.white,
          decorationThickness: isUnderLine ? 2 : 0,
          decoration:
              isUnderLine ? TextDecoration.underline : TextDecoration.none);

  static interNormal(
          {double size = 16,
          Color color = AppColors.black,
          TextDecoration textDecoration = TextDecoration.none,
          double letterSpacing = 0}) =>
      TextStyle(
          fontFamily: 'Cereal',
          fontSize: size.sp,
          fontWeight: FontWeight.w400,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);
}
