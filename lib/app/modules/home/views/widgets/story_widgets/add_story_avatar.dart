import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../common/app_color/app_colors.dart';

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
        GestureDetector(
          onTap: _pickMedia,
          child: Stack(
            children: [
              CircleAvatar(
                radius: Get.width * 0.094,
                backgroundColor: AppColors.white,
                child: CircleAvatar(
                  radius: Get.width * 0.088,
                  backgroundColor: AppColors.black,
                  child: CircleAvatar(
                    radius: Get.width * 0.08,
                    backgroundColor: AppColors.grey,
                    backgroundImage: _selectedMediaPath != null
                        ? FileImage(File(_selectedMediaPath!))
                        : null,
                    child: _selectedMediaPath == null
                        ? Icon(
                            Icons.add,
                            size: Get.width * 0.05,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: Get.width * 0.03,
                  backgroundColor: AppColors.white,
                  child: Icon(
                    Icons.add,
                    size: Get.width * 0.045,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Text(
          'Your Story',
          style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.03),
        ),
      ],
    );
  }

  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = await picker.pickImage(source: ImageSource.gallery);
    if (media != null) {
      setState(() {
        _selectedMediaPath = media.path;
      });
    }
  }
}
