import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 380,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.forgotImage,
                    fit: BoxFit.cover,
                    scale: 4,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        AppImages.back,
                        scale: 4,
                      )),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.black,
                      width: 4.0,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: AppColors.mainColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sh16,
                      Text(
                        'Forgot Password',
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Please enter your email address to receive the verification code',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      CustomTextField(
                        controller: forgotPasswordController.emailTEController,
                        hintText: 'Enter your email',
                        preIcon: Image.asset(
                          AppImages.message,
                          scale: 4,
                        ),
                      ),
                      sh24,
                      // GestureDetector(
                      //   onTap: () {
                      //     //Get.to(() => ForgotPasswordView());
                      //   },
                      //   child: Text(
                      //     'Try another way ',
                      //     style: h4.copyWith(
                      //       color: AppColors.secondaryOrangeColor,
                      //     ),
                      //   ),
                      // ),
                      sh16,
                      Obx(
                        () => forgotPasswordController.isLoading.value
                            ? CustomLoader(color: AppColors.white)
                            : CustomButton(
                                text: 'Send',
                                onPressed: () {
                                  forgotPasswordController.forgotPassword(
                                      email: forgotPasswordController
                                          .emailTEController.text
                                          .trim()
                                          .toLowerCase());
                                },
                              ),
                      ),
                      sh16,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
