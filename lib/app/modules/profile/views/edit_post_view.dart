import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/upload_post/controllers/upload_post_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dropdown.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../signup/controllers/signup_controller.dart';

class EditPostView extends StatefulWidget {
  final String location;
  final List<String> images;
  final String description;
  final String categoryId;

  const EditPostView({
    super.key,
    required this.location,
    required this.images,
    required this.description,
    required this.categoryId,
  });

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  final UploadPostController postController = Get.put(UploadPostController());
  final SignupController signupController = Get.put(SignupController());

  @override
  void initState() {
    super.initState();
    postController.toggleMode(false); // Ensure it's not in reel mode

    // Set initial values
    postController.postContentController.text = widget.description;
    postController.locationController.text = widget.location;
    postController.selectedCategoryId.value = widget.categoryId;

    // Separate image URLs from local file paths
    for (var imagePath in widget.images) {
      if (imagePath.startsWith('http')) {
        postController.originalImageUrls.add(imagePath); // Remote image
      } else {
        postController.selectedImages.add(File(imagePath)); // Local file
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Edit Post'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category', style: h3),
            sh8,
            Obx(() {
              if (signupController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (signupController.categories.isEmpty) {
                return const Text(
                  'No categories available',
                  style: TextStyle(color: AppColors.red),
                );
              }

              final items = signupController.categories;
              return Obx(() => CustomDropdown(
                    value: items
                        .firstWhereOrNull((cat) =>
                            cat.id == postController.selectedCategoryId.value)
                        ?.name,
                    items: items.map((cat) => cat.name!).toList(),
                    hintText: 'Select your pet category',
                    onChanged: (value) {
                      final matched =
                          items.firstWhereOrNull((cat) => cat.name == value);
                      if (matched != null) {
                        postController.selectedCategoryId.value = matched.id!;
                      }
                    },
                  ));
            }),
            sh16,
            Text('Add Location', style: h3),
            sh8,
            CustomTextField(
              hintText: 'Enter Location',
              borderColor: AppColors.black,
              controller: postController.locationController,
            ),
            sh16,
            Obx(() {
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.black),
                ),
                child: postController.selectedImages.isEmpty
                    ? GestureDetector(
                        onTap: postController.pickImages,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.upload, scale: 4),
                            sw8,
                            Text('Click here to select photos', style: h4),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: postController.selectedImages.length,
                        itemBuilder: (context, index) {
                          final image = postController.selectedImages[index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image,
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
                                      postController.removeImage(index),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.7),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              );
            }),
            sh8,
            Text('Write a description for the post', style: h3),
            sh8,
            CustomTextField(
              controller: postController.postContentController,
              height: 150,
              borderColor: AppColors.black,
              hintText: 'Enter post description...',
            ),
            sh16,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
                sw12,
                Expanded(
                  child: Obx(() => CustomButton(
                        text: postController.isLoading.value
                            ? 'Saving...'
                            : 'Save',
                        onPressed: postController.isLoading.value
                            ? () {}
                            : () => postController.postContent(),
                      )),
                ),
              ],
            ),
            sh30,
          ],
        ),
      ),
    );
  }
}
