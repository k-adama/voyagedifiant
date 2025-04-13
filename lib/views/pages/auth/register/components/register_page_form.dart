import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
import 'package:country_picker/country_picker.dart';

const List<String> list = <String>['Soubré', 'Gagnoa', 'Boundiali', 'Abidjan'];

class RegisterPageForm extends StatefulWidget {
  const RegisterPageForm({super.key});

  @override
  State<RegisterPageForm> createState() => _RegisterPageFormState();
}

class _RegisterPageFormState extends State<RegisterPageForm> {
  String? selectedCity;
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = Get.find();
  String? dropdownValue;
  final FocusNode myFocusNode = FocusNode();

  Future<void> onRegister() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await _authController.onRegister();
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
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Veuillez entrer une adresse e-mail valide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'email_adress'.tr,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    errorText: authController.emailError.value.isNotEmpty
                        ? authController.emailError.value
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FormField<String>(
                  validator: (value) {
                    if (selectedCity == null) {
                      return 'Veuillez sélectionner une ville';
                    }
                    return null;
                  },
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              showSearch: true,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCity = country.name;
                                  state.didChange(country.name);
                                });
                                authController.setCity(country.name);
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 14, fontFamily: 'Poppins'),
                                bottomSheetHeight:
                                    MediaQuery.of(context).size.height * 0.7,
                                inputDecoration: InputDecoration(
                                  hintText: 'select_city'.tr,
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              errorText:
                                  state.hasError ? state.errorText : null,
                              errorStyle: const TextStyle(
                                  height:
                                      0.8), // réduit la hauteur du texte d'erreur
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedCity ?? 'select_city'.tr,
                                  style: TextStyle(
                                      color: state.hasError
                                          ? const Color.fromARGB(
                                              255, 150, 19, 9)
                                          : AppColors.black,
                                      fontSize: 16),
                                ),
                                const Icon(Icons.arrow_drop_down,
                                    color: AppColors.black),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone';
                    }
                    return null;
                  },
                  errorText: authController.phoneError.value.isNotEmpty
                      ? authController.phoneError.value
                      : null,
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
    });
  }
}
