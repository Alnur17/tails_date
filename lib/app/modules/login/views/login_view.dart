import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:tails_date/app/modules/signup/views/signup_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                AppImages.loginImage,
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
                        'Log In',
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Hii! Welcome back',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
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
                      sh24,
                      GestureDetector(
                        onTap: (){
                          Get.to(() => ForgotPasswordView());
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Forgot the password ',
                            style: h4.copyWith(
                              color: AppColors.secondaryOrangeColor,
                            ),
                          ),
                        ),
                      ),
                      sh16,
                      CustomButton(
                        text: 'Login',
                        onPressed: () {
                          Get.to(() => DashboardView());
                        },
                      ),
                      sh16,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SignupView());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Don’t Have an account? ',
                              style: h4,
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
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
