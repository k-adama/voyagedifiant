import 'package:flutter/material.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class HotelTouristSiteItemsComponents extends StatelessWidget {
  //final Product product;
  final String? image;
  final String? name;
  const HotelTouristSiteItemsComponents({
    Key? key,
    this.image,
    this.name,
    //required this.product
  }) : super(key: key);

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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: SizedBox(
                          height: 130,
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
