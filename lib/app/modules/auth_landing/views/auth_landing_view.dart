import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/app/modules/signup/views/signup_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/auth_home_controller.dart';

class AuthLandingView extends GetView<AuthHomeController> {
  const AuthLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Image.asset(
            AppImages.authHome,
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Container(
            color: AppColors.black.withOpacity(0.3),
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Image.asset(
                  AppImages.authFlower,
                  scale: 4,
                ),
                sw16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: h1.copyWith(
                        fontSize: 40,
                        color: AppColors.white
                        //backgroundColor: AppColors.white
                      ),
                    ),
                    Text(
                      'TailsDate!',
                      style: h1.copyWith(
                        fontSize: 40,
                        color: AppColors.white,
                        //backgroundColor: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 75,
            left: 16,
            right: 16,
            child: Column(
              children: [
                CustomButton(
                  text: 'SIGN UP WITH EMAIL',
                  onPressed: () {
                    Get.to(() => SignupView());
                  },
                  backgroundColor: AppColors.fillColor,
                  textStyle: h3.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                sh8,
                Text(
                  'OR',
                  style: h3.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                sh8,
                CustomButton(
                  text: 'Continue As Guest',
                  onPressed: () {
                    Get.to(() => DashboardView());
                  },
                ),
                sh12,
                GestureDetector(
                  onTap: () {
                    Get.to(() => LoginView());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already Have an account? ',
                          style: h3.copyWith(color: Colors.white, fontSize: 18),
                        ),
                        TextSpan(
                          //recognizer: ,
                          text: 'Log In',
                          style: h3.copyWith(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.goldenYellow,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
