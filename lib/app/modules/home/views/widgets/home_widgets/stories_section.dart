import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/story_controller.dart';
import '../story_widgets/add_story_avatar.dart';
import '../story_widgets/story_avatar.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final StoryController controller = Get.put(StoryController());

    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: AddStoryAvatar(),
              ),
              if (controller.storyAuthors.value == null ||
                  controller.storyAuthors.value!.data.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox.shrink(),
                )
              else
                ...List.generate(controller.storyAuthors.value!.data.length, (index) {
                  final story = controller.storyAuthors.value!.data[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == controller.storyAuthors.value!.data.length - 1 ? 0 : 8.0,
                    ),
                    child: StoryAvatar(story: story, controller: controller),
                  );
                }),
            ],
          ),
        ),
      );
    });
  }
}