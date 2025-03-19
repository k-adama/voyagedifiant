import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/app_login_register_header.dart';
import 'package:voyagedifiant/views/pages/auth/register/components/register_page_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            const AppLoginRegisterHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 290,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'INSCRIPTION',
                          style: AppColors.interBold(),
                        ),
                        const RegisterPageForm(),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
