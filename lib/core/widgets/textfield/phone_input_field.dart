import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:voyagedifiant/views/controllers/auth/controllers/auth.controllers.dart';

class PhoneInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function(String) onCountryChanged;
  final String? initialValue;
  String? Function(String?)? validator;
  String? errorText;

  PhoneInputField({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.onCountryChanged,
    this.initialValue,
    this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      /* (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez entrer votre numéro de téléphone';
        }
        return null;
      },*/
      builder: (FormFieldState<String> field) {
        return IntlPhoneField(
          dropdownIconPosition: IconPosition.trailing,
          flagsButtonPadding: const EdgeInsets.only(left: 10),
          focusNode: focusNode,
          initialValue: initialValue,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "phone_number".tr,
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            errorText: errorText,
          ),
          languageCode: "fr",
          onChanged: (phone) {
            field.didChange(phone.completeNumber);
            onChanged(phone.completeNumber);
          },
          onCountryChanged: (country) => onCountryChanged(country.name),
        );
      },
    );
  }
}
