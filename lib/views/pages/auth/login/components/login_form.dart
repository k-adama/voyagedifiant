import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
  final _formKey = GlobalKey<FormState>();

  AuthController _authController = Get.find();
  bool isRememberMeChecked = false;
  bool isPasswordShown = false;
  final FocusNode myFocusNode = FocusNode();
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  Future<void> onLogin() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _authController.onLogin();
      /* _authController.onLogin().then((success) {
        if (_authController.isLoginError ||
            _authController.isPasswordNotValid) {
          setState(() {
            // showError = true;
          });
        }
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Theme(
        data: AppTheme.defaultTheme.copyWith(
          inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PhoneInputField(
                  focusNode: myFocusNode,
                  onChanged: (number) {
                    authController.setNumber(number);
                  },
                  onCountryChanged: (country) {},
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone';
                    }
                    return null;
                  },
                  errorText: authController.loginPhoneError.value.isNotEmpty
                      ? authController.loginPhoneError.value
                      : null,
                ),
                const SizedBox(height: 8),
                CustomField(
                  onChanged: (password) {
                    authController.setPassword(password);
                  },
                  label: Text('password'.tr),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Le mot de passe doit contenir au moins 8 caractères';
                    }
                    return null;
                  },
                  errorText: authController.passwordError.value.isNotEmpty
                      ? authController.passwordError.value
                      : null,
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
                          "remember".tr,
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
                          'forgot_password'.tr,
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
                  onPressed: () async {
                    await onLogin();
                  },
                  buttonText: "log_in".tr,
                  textColor: AppColors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
