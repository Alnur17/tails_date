import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_loader.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordView extends GetView {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Change Password',
        ),
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
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh40,
            Obx(
              () => CustomTextField(
                controller: profileController.currentPassTEController,
                preIcon: Image.asset(
                  AppImages.lock,
                  scale: 4,
                ),
                hintText: 'Current Password',
                sufIcon: GestureDetector(
                  onTap: () {
                    profileController.togglePasswordVisibility();
                  },
                  child: Image.asset(
                    profileController.isPasswordVisible.value
                        ? AppImages.eye
                        : AppImages.eyeClose,
                    scale: 4,
                  ),
                ),
                obscureText: !profileController.isPasswordVisible.value,
              ),
            ),
            sh16,
            Obx(
              () => CustomTextField(
                controller: profileController.newPassTEController,
                preIcon: Image.asset(
                  AppImages.lock,
                  scale: 4,
                ),
                hintText: 'New Password',
                sufIcon: GestureDetector(
                  onTap: () {
                    profileController.togglePasswordVisibility1();
                  },
                  child: Image.asset(
                    profileController.isPasswordVisible1.value
                        ? AppImages.eye
                        : AppImages.eyeClose,
                    scale: 4,
                  ),
                ),
                obscureText: !profileController.isPasswordVisible1.value,
              ),
            ),
            sh16,
            Obx(
              () => CustomTextField(
                controller: profileController.confirmPassTEController,
                preIcon: Image.asset(
                  AppImages.lock,
                  scale: 4,
                ),
                hintText: 'Confirm Password',
                sufIcon: GestureDetector(
                  onTap: () {
                    profileController.togglePasswordVisibility2();
                  },
                  child: Image.asset(
                    profileController.isPasswordVisible2.value
                        ? AppImages.eye
                        : AppImages.eyeClose,
                    scale: 4,
                  ),
                ),
                obscureText: !profileController.isPasswordVisible2.value,
              ),
            ),
            sh30,
            Obx(
              () => profileController.isLoading.value
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                      text: 'Confirm',
                      onPressed: () {
                        if (profileController.newPassTEController.text ==
                            profileController.confirmPassTEController.text) {
                          profileController.changePassword(
                            currentPassword:
                                profileController.currentPassTEController.text,
                            newPassword:
                                profileController.newPassTEController.text,
                            context: context,
                          );
                        } else {
                          kSnackBar(
                              message: "Password not match",
                              bgColor: AppColors.mainColor);
                        }
                      },
                    ),
            ),
            sh30
          ],
        ),
      ),
    );
  }
}
