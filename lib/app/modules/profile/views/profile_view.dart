import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/edit_profile_view.dart';
import 'package:tails_date/app/modules/profile/views/profile_setting_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Profile'),
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileSettingView());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                AppImages.settings,
                scale: 4,
              ),
            ),
          ),
        ],
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
                  // Positioned(
                  //   left: 12,
                  //   top: 12,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: Container(
                  //       height: 30,
                  //       decoration: ShapeDecoration(shape: CircleBorder(),color: AppColors.mainColor),
                  //       child: Image.asset(
                  //         AppImages.back,
                  //         scale: 4,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 12,
                  //   top: 12,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Get.to(()=> ProfileSettingView());
                  //     },
                  //     child: Container(
                  //       height: 30,
                  //       decoration: ShapeDecoration(shape: CircleBorder(),color: AppColors.mainColor),
                  //       child: Image.asset(
                  //         AppImages.settings,
                  //         scale: 4,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: AppColors.black,
                        ),
                        child: Image.asset(
                          AppImages.media,
                          scale: 4,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: -20,
                  //   left: 12,
                  //   child: CircleAvatar(
                  //     radius: 55,
                  //     backgroundImage: NetworkImage(AppImages.profileImage),
                  //     child: Align(
                  //       alignment: Alignment.bottomRight,
                  //       child: CircleAvatar(
                  //         radius: 18,
                  //         backgroundColor: AppColors.black,
                  //         child: GestureDetector(
                  //             onTap: () {
                  //               log('Add image tapped');
                  //             },
                  //             child: Icon(Icons.add, color: AppColors.white)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: -50,
                    //left: MediaQuery.of(context).size.width / 2 - 66,
                    left: 12,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(AppImages.profileImage),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              log("Add icon tapped");
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.black,
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sh60,
              // Profile info
              Text(
                'Piku_The_King',
                style: h2.copyWith(fontSize: 20),
              ),
              sh12,
              Row(
                children: [
                  Image.asset(
                    AppImages.location,
                    scale: 4,
                  ),
                  sw8,
                  Text(
                    '231-A, Florida, USA.',
                    style: h4,
                  ),
                ],
              ),
              sh16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      onPressed: () {},
                      text: '0 Friends',
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.black,
                      textStyle: h3.copyWith(color: AppColors.black),
                    ),
                  ),
                  sw12,
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      onPressed: () {
                        Get.to(() => EditProfileView());
                      },
                      text: 'Edit Profile',
                    ),
                  ),
                ],
              ),
              sh20,
              // Attributes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: AttributeTile(label: 'Gender', value: 'Male')),
                  sw12,
                  Expanded(child: AttributeTile(label: 'Age', value: '1 Year')),
                  sw12,
                  Expanded(
                      child: AttributeTile(label: 'Category', value: 'Cat')),
                ],
              ),
              sh20,
              // Pet info
              Text(
                'Pet info',
                style: h2.copyWith(fontSize: 18),
              ),
              sh16,
              Text(
                'Hi, I’m Gultush! I’m a cheerful and energetic cat who loves to explore and play all day long. My favorite activities include chasing toys, basking in sunny spots, and snuggling up for cozy naps. I’m not just a pet—I’m a bundle of joy that brings endless happiness and love to my family! 🐾✨',
                style: h4,
              ),
              sh16,
              // Pet Owner Info
              Text(
                'Pet Owner',
                style: h3,
              ),
              sh12,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: AppColors.fillColorTwo,
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      AppImages.loginImage,
                    ),
                  ),
                  title: Text(
                    'Ria Tamanna',
                    style: h4,
                  ),
                  subtitle: Text(
                    'Single, Female',
                    style: h6,
                  ),
                ),
              ),
              sh16,
              // Posts and Collections
              Row(
                children: [
                  Expanded(child: InfoCard(label: '0 Posts')),
                  sw12,
                  Expanded(child: InfoCard(label: '0 Collections')),
                ],
              ),
              sh20,
              // Footer illustration
              Image.asset(
                AppImages.placeHolderImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttributeTile extends StatelessWidget {
  final String label;
  final String value;

  const AttributeTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryOrangeColor),
        color: AppColors.fillColorTwo,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: h4.copyWith(color: AppColors.secondaryOrangeColor),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: h4.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;

  const InfoCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
