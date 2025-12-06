import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final List<String> highlightedText;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.highlightedText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ======= TOP IMAGE =======
          SizedBox(
            height: Get.height * 0.55,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              scale: 4,
            ),
          ),

          // ======= CURVED CONTAINER =======
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                border: Border(
                  top: BorderSide(
                    color: AppColors.black,
                    width: 4.0,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: h1,
                      children: _buildHighlightedText(),
                    ),
                  ),
                  sh16,
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: h4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Highlight logic =====
  List<TextSpan> _buildHighlightedText() {
    List<TextSpan> spans = [];
    final words = title.split(' ');

    for (var word in words) {
      if (highlightedText.contains(word)) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(color: AppColors.secondaryOrangeColor),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(color: AppColors.white),
          ),
        );
      }
    }

    return spans;
  }
}

