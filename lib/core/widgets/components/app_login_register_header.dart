import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class AppLoginRegisterHeader extends StatelessWidget {
  final bool isLogo;
  final bool isNotHome;
  final bool isLogin;
  const AppLoginRegisterHeader({
    super.key,
    this.isLogo = true,
    this.isNotHome = true,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isLogin ? 310 : 210,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: isNotHome == true
                ? const AssetImage('assets/images/header.png')
                : const AssetImage('assets/images/home-header.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
          )),
      child: isLogo == true
          ? Center(
              child: Image.asset('assets/icons/logo-voyage.png'),
            )
          : Center(
              child: Text(
                  "ENVIE D'UN SÉJOUR DE QUALITÉ SANS\n"
                  "SOUCIS DE DÉPLACEMENT ?\n"
                  "VOUS ÊTES À LA BONNE PORTE.",
                  textAlign: TextAlign.center,
                  style: AppColors.interBold(
                    size: 14,
                    color: AppColors.white,
                    fontStyle: FontStyle.italic,
                  )),
            ),
    );
  }
}
