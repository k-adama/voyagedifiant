import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/textfield/password_field.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("MON PROFIL",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                SizedBox(height: 30,),
               TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,size:30, color: AppColors.signUpColor,),
                  hintText: "Yabo Kao Chara Adewalé",
                 enabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(color: AppColors.gray, width: 2),
                 ) ,
                 focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 2)),
                ),
               ),
               SizedBox(height: 25,),
               PhoneInputField(
               onChanged: (number) {
                  print('Numéro : $number');
                },
                 onCountryChanged: (country) {
                  print('Pays : $country');
                },),
                SizedBox(height: 25,),
                TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,size:30, color: AppColors.signUpColor,),
                  hintText: "yaooya@gmail.com",
                 enabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(color: AppColors.gray, width: 2),
                 ) ,
                 focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 2)),
                ),
               ),
               SizedBox(height: 30,),
                AppCustomButton(onPressed:(){} , buttonText: "Enregistrer", 
                   textColor: AppColors.white,
                  buttonColor: AppColors.primaryColor,
                 borderRadius: BorderRadius.circular(5),
                 ),
              ],
            ),
          )),
    );
  }
}