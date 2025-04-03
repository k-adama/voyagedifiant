import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/app_bar.dart';
import 'package:voyagedifiant/core/widgets/components/appbar/drawer_page.component.dart';
import 'package:voyagedifiant/core/widgets/components/publicity_container.dart';
import 'package:voyagedifiant/core/widgets/components/search_bar_component.dart';
import 'package:voyagedifiant/views/pages/home/components/sejour/components/sejour_card.dart';

class AllSejourItems extends StatefulWidget {
  const AllSejourItems({super.key});

  @override
  State<AllSejourItems> createState() => _AllSejourItemsState();
}

class _AllSejourItemsState extends State<AllSejourItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarComponent(),
      ),
      endDrawer: const Drawer(
        backgroundColor: AppColors.white,
        child: DrawerPageComponent(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              const SearchBarComponent(
                text: 'Rechercher un Motel',
              ),
              const PublicityContainer(
                name:
                    'Voulez-vous passer un séjour memorable? Vous êtes à la bonne porte',
                background: 'assets/icons/Hotel Booking-rafiki 1.png',
              ),
              AutoHeightGridView(
                shrinkWrap: true,
                crossAxisCount: 1,
                mainAxisSpacing: 2,
                itemCount: 5,
                builder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 4,
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      scale: 0.5,
                      child: FadeInAnimation(
                          child: SejourCard(
                        name: 'Hôtel parlementaire',
                        description: 'Ceci est un hotel de luxe 5 étoiles',
                        price: '35000',
                        location: 'Yamoussoukro',
                        onTap: () {
                          Get.toNamed(Routes.SEJOUR_DETAILS);
                        },
                      )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
