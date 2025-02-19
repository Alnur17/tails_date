import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 330,
              width: double.infinity,
              child: Image.asset(
                AppImages.signUpImage,
                fit: BoxFit.cover,
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
                        'Sign Up',
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Fill your information below or register with your social account',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      // Input fields
                      CustomTextField(
                        hintText: 'Pet Name',
                        preIcon: Image.asset(
                          AppImages.person,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      CustomTextField(
                        hintText: 'Enter your email',
                        preIcon: Image.asset(
                          AppImages.message,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      CustomTextField(
                        hintText: 'Enter your password',
                        preIcon: Image.asset(
                          AppImages.lock,
                          scale: 4,
                        ),
                        sufIcon: Image.asset(
                          AppImages.eyeClose,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      CustomTextField(
                        hintText: 'Confirm your password',
                        preIcon: Image.asset(
                          AppImages.lock,
                          scale: 4,
                        ),
                        sufIcon: Image.asset(
                          AppImages.eyeClose,
                          scale: 4,
                        ),
                      ),
                      sh24,
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            activeColor: AppColors.black,
                          ),
                          Text(
                            'By agreeing to the ',
                            style: TextStyle(color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle Terms & Conditions tap
                            },
                            child: Text(
                              'Terms & Condition',
                              style: h4.copyWith(
                                  color: AppColors.secondaryOrangeColor),
                            ),
                          ),
                        ],
                      ),
                      sh16,
                      CustomButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Get.to(()=> DashboardView());
                        },
                      ),
                      sh16,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(()=> LoginView());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Already Have an account? ',
                              style: h4,
                              children: [
                                TextSpan(

                                  text: 'Log In',
                                  style: h3.copyWith(
                                    color: AppColors.secondaryOrangeColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sh16
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
