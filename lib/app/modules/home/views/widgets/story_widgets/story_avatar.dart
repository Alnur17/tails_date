// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../common/app_color/app_colors.dart';
// import '../../../../../../common/app_text_style/styles.dart';
// import '../../../../../../common/size_box/custom_sizebox.dart';
// import '../../story_view.dart';
//
// class StoryAvatar extends StatelessWidget {
//   final Map<String, String> story;
//
//   const StoryAvatar({required this.story, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Get.to(() => const StoryView());
//           },
//           child: CircleAvatar(
//             radius: Get.width * 0.094,
//             backgroundColor: AppColors.black,
//             child: CircleAvatar(
//               radius: Get.width * 0.09,
//               backgroundColor: AppColors.mainColor,
//               child: CircleAvatar(
//                 radius: Get.width * 0.085,
//                 backgroundImage: NetworkImage(story['imageUrl']!),
//               ),
//             ),
//           ),
//         ),
//         sh8,
//         Text(
//           story['name']!,
//           style: h7.copyWith(fontWeight: FontWeight.w700),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/app_color/app_colors.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../../../../../../common/size_box/custom_sizebox.dart';
import '../../../model/all_stories_model.dart';
import '../../story_view.dart';

class StoryAvatar extends StatelessWidget {
  final AllStoryDatum story;

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
                backgroundImage: NetworkImage(story.image ?? ''),
                onBackgroundImageError: (error, stackTrace) => Icon(
                  Icons.person,
                  size: Get.width * 0.06,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        sh8,
        Text(
          story.author?.name ?? 'Unknown',
          style: h7.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}