import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_dropdown.dart';
import '../controllers/upload_post_controller.dart';

class UploadPostView extends StatelessWidget {
  final controller = Get.put(UploadPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Create Post or Reels'),
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
              sh16,
              Row(
                children: [
                  Expanded(
                    child: Obx(() => CustomButton(
                      text: 'Create Posts',
                      onPressed: () => controller.toggleMode(false),
                      textStyle: h3.copyWith(
                        color: controller.isCreatingReel.value
                            ? Colors.black
                            : Colors.white,
                      ),
                      backgroundColor: controller.isCreatingReel.value
                          ? AppColors.transparent
                          : AppColors.black,
                    )),
                  ),
                  sw12,
                  Expanded(
                    child: Obx(() => CustomButton(
                      text: 'Create Reels',
                      onPressed: () => controller.toggleMode(true),
                      textStyle: h3.copyWith(
                        color: controller.isCreatingReel.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      backgroundColor: controller.isCreatingReel.value
                          ? AppColors.black
                          : AppColors.transparent,
                    )),
                  ),
                ],
              ),
              sh16,
              Obx(() {
                if (!controller.isCreatingReel.value) {
                  // Post Creation UI
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Field
                      Text('Category', style: h3),
                      sh8,
                      CustomDropdown(
                        items: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                        hintText: 'Select an option',
                        onChanged: (value) {
                          print('Selected value: $value');
                        },
                      ),
                      sh16,
                      // Location Field
                      Text('Add Location', style: h3),
                      sh8,
                      CustomTextField(
                        hintText: 'Enter Location',
                        borderColor: AppColors.black,
                      ),
                      sh16,
                      // Image Picker
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black),
                        ),
                        child: controller.selectedImages.isEmpty
                            ? GestureDetector(
                          onTap: controller.pickImages,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.upload,
                                scale: 4,
                              ),
                              sw8,
                              Text('Click here to select photos',
                                  style: h4),
                            ],
                          ),
                        )
                            : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: controller.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    controller.selectedImages[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.removeImage(index),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      sh16,
                      Text('Write a description for the post', style: h3),
                      sh8,
                      CustomTextField(
                        controller: controller.postContentController,
                        height: 150,
                        borderColor: AppColors.black,
                        hintText: 'Enter post description...',
                      ),
                    ],
                  );
                } else {
                  // Reel Creation UI
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black),
                        ),
                        child: controller.selectedVideo.value == null
                            ? GestureDetector(
                          onTap: controller.pickVideo,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.upload,
                                scale: 4,
                              ),
                              sw8,
                              Text('Click here to select a video',
                                  style: h4),
                            ],
                          ),
                        )
                            : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                AppImages.placeHolderImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: controller.removeVideo,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                  Colors.black.withOpacity(0.7),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      sh16,
                      Text('Write a description for the reel', style: h3),
                      sh8,
                      CustomTextField(
                        controller: controller.postContentController,
                        height: 250,
                        borderColor: AppColors.black,
                        hintText: 'Enter reel description...',
                      ),
                    ],
                  );
                }
              }),
              sh16,
              CustomButton(
                text: 'Upload',
                onPressed: controller.postContent,
              ),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}
