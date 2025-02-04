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

class EditPostView extends StatelessWidget {
  //final String selectedCategory;
  final String location;
  final List<String> images;
  final String description;

  const EditPostView({
    super.key,
    //required this.selectedCategory,
    required this.location,
    required this.images,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final UploadPostController postController = Get.put(UploadPostController());

    // Set initial values
    postController.postContentController.text = description;
    postController.selectedImages.assignAll(
        images.map((e) => File(e)).toList()); // Convert to File list if needed

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
            CustomDropdown(
              items: [
                'Cats',
                'Dogs',
                'Birds',
                'Exotic Animals',
                'Farm Animals'
              ],
              hintText: 'Select an option',
              onChanged: (value) {},
            ),
            sh16,
            Text('Add Location', style: h3),
            sh8,
            CustomTextField(
              hintText: 'Enter Location',
              borderColor: AppColors.black,
              controller:
                  TextEditingController(text: location), // Prefill location
            ),
            sh16,
            Obx(
              () {
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
                                  child: image.path.startsWith(
                                          'http') // Check if it's a URL
                                      ? Image.network(
                                          image.path, // Use URL
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Image.file(
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
                                      child: Icon(Icons.close,
                                          color: Colors.white, size: 16),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                );
              },
            ),
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
                    onPressed: () {
                      Get.back();
                      //postController.postContent();
                    },
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
                sw12,
                Expanded(
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () {
                      postController.postContent(); // Save edited content
                    },
                  ),
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
