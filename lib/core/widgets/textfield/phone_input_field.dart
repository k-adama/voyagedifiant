import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
      decoration: InputDecoration(
        labelText: "phone_number".tr,
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      languageCode: "fr",
      onChanged: (phone) => onChanged(phone.completeNumber),
      onCountryChanged: (country) => onCountryChanged(country.name),
    );
  }
}
