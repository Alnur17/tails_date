import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath;
  final Widget child;

  const BackgroundImage({
    super.key,
    required this.imagePath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            imagePath,
            scale: 4,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
