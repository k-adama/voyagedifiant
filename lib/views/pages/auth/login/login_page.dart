import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/dont_have_account_row.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              Container(
                color: AppColors.scaffoldWithBoxBackground,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(40))),
                child: Center(
                  child: Image.asset("assets/icons/logo-voyage.png"),
                ),
              )
            ],
          )),
          SizedBox(
            height: 500,
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
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CONNEXION",
                        style: AppColors.interBold(),
                      ),
                      const LoginPageForm(),
                      const DontHaveAccountRow(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // body: SafeArea(
      // child: SingleChildScrollView(
      //   child: Stack(
      //     children: [
      // const AppLoginRegisterHeader(),
      // SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   child: Stack(
      //     children: [
      //       Positioned(
      //         top: 300,
      //         left: 0,
      //         right: 0,
      //         bottom: 0,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Text(
      //               'CONNEXION',
      //               style: AppColors.interBold(),
      //             ),
      //             const LoginPageForm(),
      //             const DontHaveAccountRow(),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      //       ],
      //     ),
      //   ),
      // )

      /*  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-page-image.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/logo-voyage.png'),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Text(
                  'CONNEXION',
                  style: AppColors.interBold(),
                ),
              ),
              const LoginPageForm(),
              const DontHaveAccountRow(),
            ],
          )),
        ),
      ),*/
    );
  }
}
