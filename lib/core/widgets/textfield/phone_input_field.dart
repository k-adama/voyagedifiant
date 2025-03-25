import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function(String) onCountryChanged;

  const PhoneInputField({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'Numéro de téléphone',
        border: OutlineInputBorder(
        borderSide: BorderSide(),
        ),
      ),
      languageCode: "fr",
      onChanged: (phone) => onChanged(phone.completeNumber),
      onCountryChanged: (country) => onCountryChanged(country.name),
    );
  }
}
