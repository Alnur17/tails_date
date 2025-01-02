import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/app_color/app_colors.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../../story_view.dart';

class StoryAvatar extends StatelessWidget {
  final Map<String, String> story;

  const StoryAvatar({required this.story, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => const StoryView());
          },
          child: CircleAvatar(
            radius: Get.width * 0.094,
            backgroundColor: AppColors.black,
            child: CircleAvatar(
              radius: Get.width * 0.09,
              backgroundColor: AppColors.mainColor,
              child: CircleAvatar(
                radius: Get.width * 0.085,
                backgroundImage: NetworkImage(story['imageUrl']!),
              ),
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Text(
          story['name']!,
          style: h7.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
