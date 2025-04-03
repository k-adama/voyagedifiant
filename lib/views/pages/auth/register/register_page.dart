import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.4,
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.scaffoldWithBoxBackground,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            child: Center(
                              child:
                                  Image.asset("assets/icons/logo-voyage.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.primaryColor,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.scaffoldWithBoxBackground,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(97),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
