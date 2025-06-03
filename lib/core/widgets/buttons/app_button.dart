import 'package:flutter/material.dart';

class AppCustomButton extends StatelessWidget {
  final Future<void> Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const AppCustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 18.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(26)),
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          padding: padding,
          shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
