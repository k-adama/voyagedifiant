import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function(String) onCountryChanged;
  final String? initialValue;

  const PhoneInputField({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.onCountryChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Veuillez entrer un numéro valide';
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntlPhoneField(
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
                errorText: field.errorText,
              ),
              languageCode: "fr",
              onChanged: (phone) {
                field.didChange(phone.completeNumber);
                onChanged(phone.completeNumber);
              },
              onCountryChanged: (country) => onCountryChanged(country.name),
            ),
          ],
        );
      },
    );
  }
}
