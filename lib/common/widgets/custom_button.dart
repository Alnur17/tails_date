import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? isTextStyleSelected;
  final double? height;
  final String? imageAssetPath;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isTextStyleSelected,
    this.height = 54,
    this.borderColor,
    this.imageAssetPath, this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: backgroundColor ?? AppColors.black,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageAssetPath != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    imageAssetPath!,
                    scale: 4,
                  ),
                ),
              ],
              Text(
                text,
                style: h3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isTextStyleSelected != null
                      ? AppColors.black
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
