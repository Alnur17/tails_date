import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/app_color/app_colors.dart';
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
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: Get.width * 0.088,
              backgroundColor: AppColors.black,
              child: CircleAvatar(
                radius: Get.width * 0.08,
                backgroundImage: NetworkImage(story['imageUrl']!),
              ),
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Text(
          story['name']!,
          style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.03),
        ),
      ],
    );
  }
}
