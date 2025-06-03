import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voyagedifiant/core/utils/validators.dart';

class CustomField extends StatefulWidget {
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool isEyes;
  final Widget? label;
  final Function(String)? onChanged;
  String? errorText;
  TextEditingController? controller;
  // final bool isPasswordValidator;

  CustomField({
    Key? key,
    this.onFieldSubmitted,
    this.validator,
    this.isEyes = true,
    this.label,
    this.onChanged,
    this.errorText,
    this.controller,
    // this.isPasswordValidator = true,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isPasswordShown = false;

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ?? Validators.password.call,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
      obscureText: !isPasswordShown,
      decoration: InputDecoration(
        errorText: widget.errorText,
        label: widget.label,
        suffixIcon: Material(
          color: Colors.transparent,
          child: widget.isEyes == true
              ? IconButton(
                  onPressed: onPassShowClicked,
                  icon: isPasswordShown
                      ? SvgPicture.asset(
                          'assets/icons/eye.svg',
                          width: 24,
                        )
                      : SvgPicture.asset(
                          'assets/icons/eyes_close.svg',
                          width: 24,
                        ),
                )
              : Container(),
        ),
      ),
    );
  }
}
