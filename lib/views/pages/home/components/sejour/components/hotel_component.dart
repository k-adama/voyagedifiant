import 'package:flutter/material.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/route_manager.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/routes/app_pages.dart';

class HotelComponents extends StatelessWidget {
  final List<HotelModel> hotels;
  final String? image;
  const HotelComponents({
    super.key,
    this.image,
    required this.hotels,
  });

  @override
  Widget build(BuildContext context) {
    if (hotels.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.signUpColor),
      );
    }
    return AutoHeightGridView(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      itemCount: hotels.take(3).length,
      builder: (context, index) {
        final hotel = hotels[index];
        return AnimationConfiguration.staggeredGrid(
          columnCount: 4,
          position: index,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
            scale: 0.5,
            child: FadeInAnimation(
                child: InkWell(
              onTap: () {
                Get.toNamed(Routes.SEJOUR_DETAILS, arguments: hotel);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: AppDefaults.borderRadius,
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          image ?? 'assets/images/sofi.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      hotel.name ?? 'pas de nom',
                      style: AppColors.interBold(
                        size: 14,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
