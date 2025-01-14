import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_dropdown.dart';
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
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Edit Profile'),
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
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.black),
                        child: Image.asset(
                          AppImages.media,
                          scale: 4,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 16,
                    //left: MediaQuery.of(context).size.width / 2 - 66,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(AppImages.profileImage),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.black,
                            child: GestureDetector(
                              onTap: () {
                                log('Add icon tapped');
                              },
                              child: Icon(Icons.add, color: AppColors.white),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              sh60,
              // Profile info
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Remove Image',
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
              CustomDropdown(
                items: ['Male', 'Female'],
                hintText: 'Select your pet gender',
                onChanged: (value) {
                  log('Selected value: $value');
                },
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
              CustomDropdown(
                items: [
                  'Cat',
                  'Dog',
                  'Bird',
                  'Exotic Animal',
                  'Farm Animal',
                ],
                hintText: 'Select your pet category',
                onChanged: (value) {
                  log('Selected value: $value');
                },
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
              CustomDropdown(
                items: ['Single', 'Married'],
                hintText: 'Select your pet gender',
                onChanged: (value) {
                  log('Selected value: $value');
                },
              ),
              sh16,
              Text(
                'Gender',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              CustomDropdown(
                items: ['Male', 'Female'],
                hintText: 'Select your gender',
                onChanged: (value) {
                  log('Selected value: $value');
                },
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
