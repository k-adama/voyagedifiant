import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class PhoneInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function(String) onCountryChanged;
  final String? initialValue;
  final String? initialCountryCode;
  String? Function(String?)? validator;
  String? errorText;
  final bool isNotBorderBottom;

  PhoneInputField({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.onCountryChanged,
    this.initialValue,
    this.initialCountryCode,
    this.validator,
    this.errorText,
    this.isNotBorderBottom = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> field) {
        return IntlPhoneField(
          dropdownIconPosition: IconPosition.trailing,
          flagsButtonPadding: const EdgeInsets.only(left: 10),
          focusNode: focusNode,
          initialValue: initialValue,
          initialCountryCode: initialCountryCode,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "phone_number".tr,
            enabledBorder: isNotBorderBottom
                ? null
                : const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray, width: 2),
                  ),
            border: isNotBorderBottom
                ? const OutlineInputBorder(
                    borderSide: BorderSide(),
                  )
                : const UnderlineInputBorder(),
            errorText: errorText ?? field.errorText,
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
