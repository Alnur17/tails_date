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
          'Your Story',
          style: h7.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  // Future<void> _pickMedia() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? media = await picker.pickImage(source: ImageSource.gallery);
  //   if (media != null) {
  //     setState(() {
  //       _selectedMediaPath = media.path;
  //     });
  //   }
  // }
}
