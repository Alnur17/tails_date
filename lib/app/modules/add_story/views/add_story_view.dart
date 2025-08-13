import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/add_story_controller.dart';

class AddStoryView extends GetView<AddStoryController> {
  const AddStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddStoryController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Add Story'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.selectedImagePath.value.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await controller.pickImageFromCamera();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.camera, scale: 4),
                                sw8,
                                Text('Use a camera', style: h4, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sw16,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await controller.pickImageFromGallery();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.gallery, scale: 4),
                                sw8,
                                Text('Choose from Gallery', style: h4, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(controller.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedImagePath.value = '';
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close, color: AppColors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
              sh16,
              Text('Write something here', style: h3),
              sh8,
              CustomTextField(
                height: 250,
                borderColor: AppColors.black,
              ),
              sh20,
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                  text: 'Add Story',
                  onPressed: () {
                    controller.uploadStory();
                  },
                );
              }),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}
