import 'package:flutter/material.dart';

class AppLoginRegisterHeader extends StatelessWidget {
  const AppLoginRegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 310,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/header.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Image.asset('assets/icons/logo-voyage.png'),
      ),
    );
  }
}
