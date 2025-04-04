import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      body: LayoutBuilder(
        builder: (context, Constraints) {
          return Column(
            children: [
              SizedBox(
                height: Constraints.maxHeight*0.4,
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
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColors.scaffoldWithBoxBackground,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(97),
                            )),
                            constraints: BoxConstraints(
                              minHeight: Constraints.maxHeight*0.6
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                             "CONNEXION",
                              style: AppColors.interBold(),
                            ),
                            const SizedBox(height: 20),
                             const SizedBox(height: 20),
                            const LoginPageForm(),
                            const DontHaveAccountRow(),
                            const SizedBox(height: 40), 
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
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


