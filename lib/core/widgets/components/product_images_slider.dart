import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';
import 'package:voyagedifiant/core/constants/app_defaults.dart';
import 'package:voyagedifiant/core/widgets/components/animated_dots.dart';
import 'network_image.dart';

class ProductImagesSlider extends StatefulWidget {
  final List<String> images;
  const ProductImagesSlider({
    super.key,
    required this.images,
  });

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  late PageController controller;
  int currentIndex = 0;
  late Timer autoSlideTimer;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    if (widget.images.isNotEmpty) {
      autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (controller.hasClients) {
          int nextPage = (currentIndex + 1) % widget.images.length;
          controller.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          setState(() {
            currentIndex = nextPage;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    autoSlideTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(
          color: AppColors.gray,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
                /* NetworkImageWithLoader(
                  images[index],
                  fit: BoxFit.cover,
                );*/
              },
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedDots(
                  totalItems: widget.images.length,
                  currentIndex: currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
