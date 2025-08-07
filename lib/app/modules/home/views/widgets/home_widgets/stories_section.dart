// import 'package:flutter/material.dart';
// import 'package:tails_date/app/data/dummy_data.dart';
//
// import '../story_widgets/add_story_avatar.dart';
// import '../story_widgets/story_avatar.dart';
//
// class StoriesSection extends StatelessWidget {
//   const StoriesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
//         child: Row(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: AddStoryAvatar(),
//             ),
//             ...List.generate(DummyData.stories.length, (index) {
//               final story = DummyData.stories[index];
//               return Padding(
//                 padding: EdgeInsets.only(
//                   right: index == DummyData.stories.length - 1 ? 0 : 8.0, // No padding for the last item
//                 ),
//                 child: StoryAvatar(story: story),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
              if (controller.isLoading.value)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircularProgressIndicator(color: Colors.black,),
                )
              else if (controller.stories.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'No stories available',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                ...List.generate(controller.stories.length, (index) {
                  final story = controller.stories[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == controller.stories.length - 1 ? 0 : 8.0,
                    ),
                    child: StoryAvatar(story: story),
                  );
                }),
            ],
          ),
        ),
      );
    });
  }
}