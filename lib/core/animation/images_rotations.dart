import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotatingSvgImage extends StatefulWidget {
  final String assetPath;
  final double size;

  const RotatingSvgImage({super.key, required this.assetPath, this.size = 100});

  @override
  State<RotatingSvgImage> createState() => _RotatingSvgImageState();
}

class _RotatingSvgImageState extends State<RotatingSvgImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Boucle infinie
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        widget.assetPath,
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
