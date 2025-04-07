import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/views/controllers/Main/controllers/main.controller.dart';

class TranslateAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TranslateAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      actions: [
        Obx(() {
          String langCode = mainController.currentLocale.value.languageCode;

          return PopupMenuButton<String>(
            onSelected: (value) {
              mainController.changeLanguage(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'fr',
                child: Row(
                  children: [
                    Text('🇫🇷'),
                    SizedBox(width: 8),
                    Text('Fr'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'en',
                child: Row(
                  children: [
                    Text('🇺🇸'),
                    SizedBox(width: 8),
                    Text('En'),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    langCode == 'en' ? '🇺🇸' : '🇫🇷',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    langCode == 'en' ? 'En' : 'Fr',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
