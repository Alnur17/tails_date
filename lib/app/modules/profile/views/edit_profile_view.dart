import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class EditProfileView extends GetView {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 16,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover photo and profile picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(AppImages.groupOfDogs),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: AppColors.mainColor),
                        child: Image.asset(
                          AppImages.back,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: AppColors.mainColor),
                        child: Image.asset(
                          AppImages.settings,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: AppColors.mainColor),
                        child: Image.asset(
                          AppImages.media,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: MediaQuery.of(context).size.width / 2 - 66,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(AppImages.profileImage),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.black,
                          child: Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              // Profile info
              Center(
                child: Text(
                  'Edit or remove image',
                  style: h5,
                ),
              ),
              sh24,
              Text(
                'Pet Name',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your pet name',
              ),
              sh16,
              Text(
                'Location',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your pet location',
              ),
              sh16,
              Text(
                'Gender',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your pet gender',
              ),
              sh16,
              Text(
                'Age',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your pet age',
              ),
              sh16,
              Text(
                'Category',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your pet category',
              ),
              sh16,
              Text(
                'Pet info',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                height: 150,
                containerColor: AppColors.white,
                hintText: 'Write here...',
              ),
              sh16,
              Text(
                'Pet Owner Profile Picture',
                style: h2.copyWith(fontSize: 18),
              ),
              sh12,
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.white,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppImages.edit,
                      scale: 4,
                    ),
                  ),
                ],
              ),

              sh16,
              Text(
                'Pet Owner Name',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Owner name',
              ),
              sh16,
              Text(
                'Relationship',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Relationship status',
              ),
              sh16,
              Text(
                'Gender',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomTextField(
                containerColor: AppColors.white,
                hintText: 'Enter your gender',
              ),
              sh30,
              CustomButton(text: 'Save', onPressed: () {}),
              sh30
            ],
          ),
        ),
      ),
    );
  }
}
