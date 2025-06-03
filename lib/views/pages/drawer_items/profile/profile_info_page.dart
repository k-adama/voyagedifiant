import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/constants/app_helpers.dart';
import 'package:voyagedifiant/core/models/user.dart';
import 'package:voyagedifiant/core/widgets/buttons/app_button.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';
import 'package:voyagedifiant/core/widgets/textfield/phone_input_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:voyagedifiant/views/controllers/home/controllers/home.controllers.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  HomeController homeController = Get.find();
  UserModel? user;
  late TextEditingController nameController;
  late TextEditingController emailController;

  String? initialPhoneNumber;
  String? initialCountryCode;

  @override
  void initState() {
    super.initState();

    user = AppHelpersCommon.getUserInLocalStorage();

    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');

    final fullPhone = user?.phone ?? '';

    if (fullPhone.startsWith('+')) {
      final match = RegExp(r'^\+(\d{1,4})(\d+)$').firstMatch(fullPhone);
      if (match != null) {
        final dialCode = '+${match.group(1)}';
        final number = match.group(2);

        initialPhoneNumber = number;

        final country = countries.firstWhere(
          (c) => c.dialCode == dialCode,
          orElse: () => countries.first,
        );

        initialCountryCode = country.code;
      }
    }

    if (initialPhoneNumber == null || initialCountryCode == null) {
      final sortedCountries = [...countries]
        ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

      for (var country in sortedCountries) {
        final dialCodeDigits = country.dialCode.replaceAll('+', '');

        if (fullPhone.startsWith(dialCodeDigits)) {
          initialCountryCode = country.code;
          initialPhoneNumber = fullPhone.substring(dialCodeDigits.length);
          break;
        }
      }

      initialCountryCode ??= 'CI';
      initialPhoneNumber ??= fullPhone;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Supprime l'ombre
        actions: const [
          TranslatePopItem(
            isDrawer: true,
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            Text("MON PROFIL",
                style: AppColors.interBold(
                  size: 18,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  size: 30,
                  color: AppColors.signUpColor,
                ),
                // hintText: user!.name ?? 'Aucun nom',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray, width: 2)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            PhoneInputField(
              isNotBorderBottom: false,
              initialValue: initialPhoneNumber,
              initialCountryCode: initialCountryCode ?? 'CI',
              onChanged: (number) {
                print('Numéro : $number');
              },
              onCountryChanged: (country) {
                print('Pays : $country');
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  size: 30,
                  color: AppColors.signUpColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray, width: 2)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => AppCustomButton(
                onPressed: homeController.isProfilChangeLoading.value
                    ? null
                    : () async {
                        final dialCodeWithoutPlus = initialCountryCode != null
                            ? countries
                                .firstWhere((c) => c.code == initialCountryCode)
                                .dialCode
                                .replaceAll('+', '')
                            : '';

                        final phone =
                            dialCodeWithoutPlus + (initialPhoneNumber ?? '');
                        await homeController.updateUserProfile({
                          'name': nameController.text,
                          'phone': phone,
                          'email': emailController.text,
                        });
                      },
                buttonText: homeController.isProfilChangeLoading.value
                    ? "Modification en cours..."
                    : "Modifier",
                textColor: AppColors.white,
                buttonColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
