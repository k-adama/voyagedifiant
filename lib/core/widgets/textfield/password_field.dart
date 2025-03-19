import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voyagedifiant/core/utils/validators.dart';

class CustomField extends StatefulWidget {
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool isEyes;
 // final bool isPasswordValidator;

  const CustomField({
    Key? key,
    this.onFieldSubmitted,
    this.validator,
    this.isEyes = true, 
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
      validator: widget.validator ?? Validators.password.call,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: TextInputAction.done,
      obscureText: !isPasswordShown,
      decoration: InputDecoration(
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
