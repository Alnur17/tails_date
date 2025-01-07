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
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Upload Post'),
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
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white,
                border: Border.all(color: AppColors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.upload,scale: 4,),
                  sw8,
                  Text('Click here to select photo or videos',style: h4,),

                ],
              ),
            ),
            sh16,
            Text(
              'Write something here',
              style: h3,
            ),
            sh8,
            CustomTextField(
              height: 200,
              borderColor: AppColors.black,
            ),
            sh20,
            CustomButton(text: 'Post', onPressed: (){}),
            sh30,
          ],
        ),
      ),
    );
  }
}
