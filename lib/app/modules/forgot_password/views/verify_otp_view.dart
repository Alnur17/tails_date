import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tails_date/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:tails_date/common/widgets/custom_loader.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';

class VerifyOtpView extends GetView {
  final String email;

  const VerifyOtpView(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController = Get.find();
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
                      Get.closeCurrentSnackbar();
                      Get.back();
                    },
                    child: Image.asset(
                      AppImages.back,
                      scale: 4,
                    ),
                  ),
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
                        'Verify Code',
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Please enter the code we just sent to $email',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      PinCodeTextField(
                        controller: forgotPasswordController.otpTEController,
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
                      // Text(
                      //   'Didn\'t receive OTP',
                      //   style: h4.copyWith(),
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Text(
                      //     'Resend Code',
                      //     style: h4.copyWith(
                      //       color: AppColors.secondaryOrangeColor,
                      //     ),
                      //   ),
                      // ),
                      Obx(() {
                        return forgotPasswordController.countdown.value > 0
                            ? Text(
                                'Resend code in ${forgotPasswordController.countdown.value}s',
                                style: h3,
                              )
                            : GestureDetector(
                                onTap:
                                    forgotPasswordController.countdown.value ==
                                            0
                                        ? () {
                                            forgotPasswordController
                                                .forgotPassword(email: email);
                                          }
                                        : null,
                                child: Text(
                                  'Resend code',
                                  style: h4.copyWith(
                                    color: AppColors.black,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.mainColor,
                                    decorationThickness: 2,
                                    decorationStyle: TextDecorationStyle.dashed,
                                  ),
                                ),
                              );
                      }),
                      sh30,
                      Obx(
                        () => forgotPasswordController.isLoading.value
                            ? CustomLoader(color: AppColors.white)
                            : CustomButton(
                                text: 'Verify',
                                onPressed: () {
                                  forgotPasswordController.verifyOtp(
                                      email: email,
                                      otp: forgotPasswordController
                                          .otpTEController.text);
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
