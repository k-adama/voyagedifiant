import 'package:flutter/material.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';

class HotelComponents extends StatelessWidget {
  //final Product product;
  final String? image;
  final String? name;
  const HotelComponents({
    super.key,
    this.image,
    this.name,
    //required this.product
  });

  @override
  Widget build(BuildContext context) {
    //var controller =
    //  Get.put<DetailController>(DetailController(product: product));
    return AutoHeightGridView(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      itemCount: 3,
      builder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          columnCount: 4,
          position: index,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
            scale: 0.5,
            child: FadeInAnimation(
                child: InkWell(
              onTap: () {},
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
                          image ?? 'assets/icons/location-icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      name ?? 'pas de nom',
                      //controller.productList[index].name,
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
