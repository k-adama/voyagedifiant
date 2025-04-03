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
import 'package:voyagedifiant/views/pages/home/components/decouverte/components/decouverte_card.dart';

class AllDecouverteItems extends StatefulWidget {
  const AllDecouverteItems({super.key});

  @override
  State<AllDecouverteItems> createState() => _AllDecouverteItemsState();
}

class _AllDecouverteItemsState extends State<AllDecouverteItems> {
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
                text: 'Rechercher un site',
              ),
              const PublicityContainer(
                name:
                    "Plongez dans une expérience unique au coeur de la Côte D'Ivoire",
                background:
                    'assets/icons/People sightseeing outdoors-cuate 1.png',
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
                          child: DecouverteCardComponent(
                        name: 'Cascade de man', 
                        description: 'Ce ci est un hotel de luxe 5 étoiles',
                        price: '35000',
                       
                        onTap: () {
                          Get.toNamed(Routes.DECOUVERTE_DETAILS);
                        },
                        depart: '09h17',
                        arrived: '17h30',
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
