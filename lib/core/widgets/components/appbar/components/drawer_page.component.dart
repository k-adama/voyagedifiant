import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class DrawerPageComponent extends StatelessWidget {
  const DrawerPageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.signUpColor,
              border: Border(
                bottom: Divider.createBorderSide(context,
                    color: AppColors.black, width: 1.0),
              ),
            ),
            child: const Padding(
                padding: EdgeInsets.only(top: 20.0), child: Text('Header')
                // DrawerPageHearderComponent(),
                )),
        // const DrawerPageBodyComponent(),
        // DrawerPageFooterComponent(),
      ],
    );
  }
}
