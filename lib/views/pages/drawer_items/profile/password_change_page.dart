import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/utils/validators.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:voyagedifiant/views/pages/auth/login/components/login_form.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Supprime l'ombre
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.language_outlined)
            )
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("MOT DE PASSE",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))
              ],
            ),
          ),
        ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text("Entrez votre mot de passe actuel", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 18),),
            CustomField(
            
            )
            ],
          ),
        ),
    );
  }
}