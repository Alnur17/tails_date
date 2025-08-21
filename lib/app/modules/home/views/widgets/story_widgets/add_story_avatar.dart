import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../../../common/app_color/app_colors.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../../../../add_story/views/add_story_view.dart';

class AddStoryAvatar extends StatefulWidget {
  const AddStoryAvatar({super.key});

  @override
  State<AddStoryAvatar> createState() => _AddStoryAvatarState();
}

class _AddStoryAvatarState extends State<AddStoryAvatar> {
  String? _selectedMediaPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: Get.width * 0.09,
              backgroundColor: AppColors.white,
              backgroundImage: _selectedMediaPath != null
                  ? FileImage(File(_selectedMediaPath!))
                  : null,
              child: _selectedMediaPath == null
                  ? Icon(
                Icons.person,
                size: Get.width * 0.06,
                color: AppColors.black,
              )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap:  () async {
                  final result = await Get.to(() => const AddStoryView());
                  if (result != null) {
                    setState(() {
                      _selectedMediaPath = result as String;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: Get.width * 0.03,
                  backgroundColor: AppColors.black,
                  child: Icon(
                    Icons.add,
                    size: Get.width * 0.045,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        sh8,
        Text(
          'Your_Story'.tr,
          style: h7.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../../common/app_color/app_colors.dart';
// import '../../../../../../common/app_text_style/styles.dart';
// import '../../../../../../common/size_box/custom_sizebox.dart';
// import '../../../../add_story/views/add_story_view.dart';
// import '../../../controllers/story_controller.dart';
//
// class AddStoryAvatar extends StatefulWidget {
//   const AddStoryAvatar({super.key});
//
//   @override
//   State<AddStoryAvatar> createState() => _AddStoryAvatarState();
// }
//
// class _AddStoryAvatarState extends State<AddStoryAvatar> {
//   String? _selectedMediaPath;
//   final StoryController controller = Get.find<StoryController>();
//   final TextEditingController _captionController = TextEditingController();
//
//   @override
//   void dispose() {
//     _captionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             CircleAvatar(
//               radius: Get.width * 0.09,
//               backgroundColor: AppColors.white,
//               backgroundImage: _selectedMediaPath != null
//                   ? FileImage(File(_selectedMediaPath!))
//                   : null,
//               child: _selectedMediaPath == null
//                   ? Icon(
//                 Icons.person,
//                 size: Get.width * 0.06,
//                 color: AppColors.black,
//               )
//                   : null,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: () async {
//                   final result = await Get.to(() => const AddStoryView());
//                   if (result != null) {
//                     setState(() {
//                       _selectedMediaPath = result as String;
//                     });
//                     // Show a dialog to input caption
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Add Caption', style: h3),
//                         content: TextField(
//                           controller: _captionController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter your story caption',
//                             hintStyle: h5,
//                           ),
//                           maxLines: 3,
//                           autofocus: true, // Ensure keyboard shows only once
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               FocusScope.of(context).unfocus(); // Hide keyboard
//                               Get.back();
//                             },
//                             child: Text('Cancel', style: h5),
//                           ),
//                           TextButton(
//                             onPressed: () async {
//                               FocusScope.of(context).unfocus(); // Hide keyboard
//                               Get.back();
//                               await controller.createStory(
//                                 mediaPath: _selectedMediaPath!,
//                                 caption: _captionController.text,
//                               );
//                               _captionController.clear();
//                             },
//                             child: Text('Submit', style: h5),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: Get.width * 0.03,
//                   backgroundColor: AppColors.black,
//                   child: Icon(
//                     Icons.add,
//                     size: Get.width * 0.045,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         sh8,
//         Text(
//           'Your Story',
//           style: h7.copyWith(fontWeight: FontWeight.w700),
//         ),
//       ],
//     );
//   }
// }