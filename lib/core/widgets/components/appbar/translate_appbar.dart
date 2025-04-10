import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/widgets/components/translate_pop_item.dart';

class TranslateAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TranslateAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.primaryColor,
      shape: const Border(
        bottom: BorderSide.none,
      ),
      actions: const [
        TranslatePopItem(),
      ],
    );
  }
}
