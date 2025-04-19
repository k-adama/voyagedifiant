import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagedifiant/core/widgets/shimmers/make_shimmer.dart';

class CommonImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double radius;
  final bool isTopBorderRadius;

  const CommonImage({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.isTopBorderRadius = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isTopBorderRadius
          ? BorderRadius.vertical(top: Radius.circular(10.r))
          : BorderRadius.circular(radius.r),
      child: imageUrl != null && imageUrl!.startsWith('http')
          // Si l'URL commence par http:// ou https://
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: width.r,
              height: height.r,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return MakeShimmer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: isTopBorderRadius
                          ? BorderRadius.vertical(top: Radius.circular(10.r))
                          : BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  height: height.r,
                  width: width.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius.r),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/images/Rectangle 11.png", // Image par défaut en cas d'erreur
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          // Si ce n'est pas une URL (image locale ou `null`), on utilise l'image par défaut
          : Image.asset(
              imageUrl ??
                  'assets/images/Rectangle 11.png', // Image par défaut si URL null
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
    );
  }
}
