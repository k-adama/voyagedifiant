import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  AuthController authController = Get.find();
  bool isRememberMeChecked = false;
  bool isPasswordShown = false;
  final FocusNode myFocusNode = FocusNode();
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      authController.onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PhoneInputField(
                focusNode: myFocusNode,
                onChanged: (number) {
                  authController.setNumber(number);
                },
                onCountryChanged: (country) {},
              ),
              const SizedBox(height: 8),
              CustomField(
                //onFieldSubmitted: (v) => onLogin(),
                validator: Validators.password.call,
                onChanged: (password) {
                  authController.setPassword(password);
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: isRememberMeChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isRememberMeChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Se rappeler de moi',
                        style: AppColors.interNormal(
                          color: AppColors.black,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.PASSWORD_FORGOT_PAGE);
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: AppColors.interNormal(
                          color: AppColors.black,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppCustomButton(
                onPressed: () => onLogin(),
                buttonText: "SE CONNECTER",
                textColor: AppColors.white,
                buttonColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
