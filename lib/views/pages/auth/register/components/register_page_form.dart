import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/app_translate.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';
import 'package:voyagedifiant/views/pages/auth/register/components/already_have_accout.dart';

const List<String> list = <String>['Soubré', 'Gagnoa', 'Boundiali', 'Abidjan'];

class RegisterPageForm extends StatefulWidget {
  const RegisterPageForm({super.key});

  @override
  State<RegisterPageForm> createState() => _RegisterPageFormState();
}

class _RegisterPageFormState extends State<RegisterPageForm> {
  String? selectedCity;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find();
  String? dropdownValue;
  final FocusNode myFocusNode = FocusNode();

  Future<void> onRegister() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await authController.onRegister();
    }
  }

  void _openCitySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'select_city'.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ...list.map((city) {
              return ListTile(
                title: Text(city),
                trailing: selectedCity == city
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => selectedCity = city);
                  Navigator.pop(context);
                  authController.setCity(city);
                },
              );
            }).toList(),
            const SizedBox(height: 16),
          ],
        );
      },
    );
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer votre nom complet';
                  }
                  return null;
                },
                onChanged: (username) {
                  authController.setUsername(username);
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'full_name'.tr,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (email) {
                  authController.setEmail(email);
                },
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer une adresse e-mail valide';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'email_adress'.tr,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: _openCitySelector,
                child: SizedBox(
                  height: 50,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCity ?? 'select_city'.tr,
                          style: const TextStyle(
                              color: AppColors.black, fontSize: 16),
                        ),
                        const Icon(Icons.arrow_drop_down,
                            color: AppColors.black),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PhoneInputField(
                focusNode: myFocusNode,
                onChanged: (number) {
                  authController.setNumber(number);
                },
                onCountryChanged: (country) {},
              ),
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
              ),
              const SizedBox(height: 12),
              AppCustomButton(
                onPressed: onRegister,
                buttonText: "sign_up_register".tr,
                textColor: AppColors.white,
                buttonColor: AppColors.primaryColor,
              ),
              const AlreadyHaveAnAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
