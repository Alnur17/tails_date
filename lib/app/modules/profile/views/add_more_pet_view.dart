import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/controllers/other_pet_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dropdown.dart';
import '../../../../common/widgets/custom_textfield.dart';

class AddMorePetView extends StatefulWidget {
  const AddMorePetView({super.key});

  @override
  State<AddMorePetView> createState() => _AddMorePetViewState();
}

class _AddMorePetViewState extends State<AddMorePetView> {
  final OtherPetController otherPetController = Get.put(OtherPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Add More Pet'),
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
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     Container(
              //       height: 200,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: NetworkImage(AppImages.groupOfDogs),
              //           fit: BoxFit.cover,
              //         ),
              //         borderRadius: BorderRadius.circular(16),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 12,
              //       right: 12,
              //       child: GestureDetector(
              //         onTap: () {},
              //         child: Container(
              //           height: 30,
              //           decoration: ShapeDecoration(
              //               shape: CircleBorder(), color: Colors.black),
              //           child: Image.asset(
              //             AppImages.media,
              //             scale: 4,
              //             color: AppColors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: -50,
              //       left: 16,
              //       //left: MediaQuery.of(context).size.width / 2 - 66,
              //       child: CircleAvatar(
              //           radius: 50,
              //           backgroundImage: NetworkImage(AppImages.profileImage),
              //           child: Align(
              //             alignment: Alignment.topRight,
              //             child: CircleAvatar(
              //               radius: 15,
              //               backgroundColor: AppColors.black,
              //               child: GestureDetector(
              //                 onTap: () {
              //                   log('Add icon tapped');
              //                 },
              //                 child: Icon(Icons.add, color: AppColors.white),
              //               ),
              //             ),
              //           )),
              //     ),
              //   ],
              // ),
              Text(
                'Upload Image',
                style: h2.copyWith(fontSize: 18),
              ),
              sh8,
              Obx(() {
                if (otherPetController.selectedImagePath.value.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await otherPetController.pickImageFromCamera();
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
                                Text('Use_Camera'.tr, style: h4, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sw16,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await otherPetController.pickImageFromGallery();
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
                                Text('Choose_From_Gallery'.tr, style: h4, textAlign: TextAlign.center),
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
                            File(otherPetController.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            otherPetController.selectedImagePath.value = '';
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
