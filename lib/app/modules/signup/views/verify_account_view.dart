import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tails_date/app/modules/signup/controllers/signup_controller.dart';
import 'package:tails_date/common/widgets/custom_loader.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';

class VerifyAccountView extends GetView<SignupController> {
  final String email;

  const VerifyAccountView(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
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
                    AppImages.verifyCodeImage,
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
            // Form section
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
                        'Verify_Code'.tr,
                        style: h2,
                      ),
                      sh8,
                      Text(
                        '${'Enter_Code_Sent_To'.tr}$email',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      PinCodeTextField(
                        controller: signupController.otpController,
                        length: 6,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: Get.height * 0.07,
                          fieldWidth: Get.width * 0.14,
                          activeColor: AppColors.white,
                          activeFillColor: AppColors.fillColor,
                          inactiveColor: AppColors.grey,
                          inactiveFillColor: AppColors.white,
                          selectedColor: AppColors.mainColor,
                          selectedFillColor: AppColors.greyLight,
                          fieldOuterPadding:
                          EdgeInsets.symmetric(horizontal: 2),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: AppColors.transparent,
                        cursorColor: AppColors.blue,
                        enablePinAutofill: true,
                        enableActiveFill: true,
                        onCompleted: (v) {},
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          log("Allowing to paste $text");
                          return true;
                        },
                        appContext: context,
                      ),
                      sh24,
                      Text(
                        'Didnt_Receive_OTP'.tr,
                        style: h4.copyWith(),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Resend_Code'.tr,
                          style: h4.copyWith(
                            color: AppColors.secondaryOrangeColor,
                          ),
                        ),
                      ),
                      sh16,
                      Obx(
                            () => signupController.isLoading.value
                            ? CustomLoader(color: AppColors.white)
                            : CustomButton(
                          text: 'Verify'.tr,
                          onPressed: () {
                            signupController.accountVerification(email);
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