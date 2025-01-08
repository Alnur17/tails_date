import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/upload_post_controller.dart';

class UploadPostView extends GetView<UploadPostController> {
  const UploadPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadPostController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Upload Photo or Video'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Location Field
            Text(
              'Add Location',
              style: h3,
            ),
            sh8,
            CustomTextField(
              hintText: 'Enter Location',
              borderColor: AppColors.black,
            ),
            sh16,

            // Image/Video Upload Section
            Obx(() {
              return Column(
                children: [
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
                          Text(
                            'Click here to select photo or videos',
                            style: h4,
                          ),
                        ],
                      ),
                    )
                        : controller.selectedImages.length == 1
                        ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            controller.selectedImages.first,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () =>
                                controller.removeImage(0),
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
                    )
                        : GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
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
                              borderRadius:
                              BorderRadius.circular(12),
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
                                  backgroundColor: Colors.black
                                      .withOpacity(0.7),
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
                  sh8,

                  // Add More Button (Visible Only When Images Are Selected)
                  if (controller.selectedImages.isNotEmpty)
                    GestureDetector(
                      onTap: controller.pickImages,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline),
                          sw8,
                          Text(
                            'Add More',
                            style: h4,
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
            sh16,

            // Write Post Section
            Text(
              'Write something here',
              style: h3,
            ),
            sh8,
            CustomTextField(
              controller: controller.postContentController,
              height: 200,
              borderColor: AppColors.black,
            ),
            sh20,

            // Post Button
            CustomButton(
              text: 'Post',
              onPressed: controller.postContent,
            ),
            sh30,
          ],
        ),
      ),
    );
  }
}
