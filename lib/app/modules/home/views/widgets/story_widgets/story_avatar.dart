import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/app_color/app_colors.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../../../../../../common/size_box/custom_sizebox.dart';
import '../../../controllers/story_controller.dart';
import '../../../model/all_author_story_model.dart';
import '../../story_view.dart';

class StoryAvatar extends StatelessWidget {
  final AllAuthDatum story;
  final StoryController controller;

  const StoryAvatar({required this.story, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            controller.isLoadingStories.value = true;
            await controller.fetchStoriesByAuthor(story.id!);
            controller.isLoadingStories.value = false;
            //if (controller.storyImageUrls.isNotEmpty) {
            if (controller.authorStories.value?.data.isNotEmpty ?? false) {
              final firstStoryId =
                  controller.authorStories.value!.data.first.id;
              Get.to(() => StoryView(
                    authorName: story.name ?? 'Unknown',
                    storyId: firstStoryId!,
                  ));
            }
            // else {
            //   kSnackBar(
            //     message: 'No stories available for this author',
            //     bgColor: AppColors.orange,
            //   );
            // }
          },
          child: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: Get.width * 0.094,
                  backgroundColor: AppColors.black,
                  child: CircleAvatar(
                    radius: Get.width * 0.09,
                    backgroundColor: AppColors.mainColor,
                    child: CircleAvatar(
                      radius: Get.width * 0.085,
                      backgroundImage: NetworkImage(story.image ?? ''),
                    ),
                  ),
                ),
                if (controller.isLoadingStories.value)
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
              ],
            );
          }),
        ),
        sh8,
        Text(
          story.name ?? '',
          style: h7.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
