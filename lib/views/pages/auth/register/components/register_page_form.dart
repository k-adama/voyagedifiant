import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/themes/app_themes.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:voyagedifiant/views/pages/auth/register/components/already_have_accout.dart';

const List<String> list = <String>['Soubré', 'Gagnoa', 'Boundiali', 'Abidjan'];

class RegisterPageForm extends StatefulWidget {
  const RegisterPageForm({super.key});

  @override
  State<RegisterPageForm> createState() => _RegisterPageFormState();
}

class _RegisterPageFormState extends State<RegisterPageForm> {
  // String dropdownValue = list.first;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? dropdownValue;
  final FocusNode myFocusNode = FocusNode();

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      // Get.offAllNamed(Routes.NUMBER_VERIFICATION_PAGE);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              validator: Validators.requiredWithFieldName('Name').call,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nom et prénoms',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: Validators.requiredWithFieldName('email').call,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Entrer votre e-mail',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 50,
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    hint: const Text('Sélectionner une ville'),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                print('Numéro : $number');
              },
              onCountryChanged: (country) {
                print('Pays : $country');
              },
            ),
            CustomField(
              onFieldSubmitted: (v) => onLogin(),
              validator: Validators.password.call,
            ),
            const SizedBox(height: 12),
            AppCustomButton(
              onPressed: () {
                Get.offAllNamed(Routes.NUMBER_VERIFICATION_PAGE);
              },
              buttonText: "S'INSCRIRE",
              textColor: AppColors.white,
              buttonColor: AppColors.primaryColor,
            ),
             const AlreadyHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
