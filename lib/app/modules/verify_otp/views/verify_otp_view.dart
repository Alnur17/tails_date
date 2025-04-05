import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tails_date/app/modules/new_password/views/new_password_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
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
                        'Please enter the code we just sent to email roy@roy.com',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      PinCodeTextField(
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
                          fieldOuterPadding: EdgeInsets.symmetric(horizontal: 2),
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
                        'Didn\'t receive OTP',
                        style: h4.copyWith(),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Text(
                          'Resend Code',
                          style: h4.copyWith(
                            color: AppColors.secondaryOrangeColor,
                          ),
                        ),
                      ),
                      sh16,
                      CustomButton(
                        text: 'Verify',
                        onPressed: () {
                          Get.to(() => NewPasswordView());
                        },
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
