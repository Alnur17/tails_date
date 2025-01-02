import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 330,
              width: double.infinity,
              child: Image.asset(
                AppImages.newPassImage,
                fit: BoxFit.contain,
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
                        'Create New Password',
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Your new password must be different from your previous password',
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      CustomTextField(
                        hintText: 'New password',
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
                      CustomButton(
                        text: 'Update',
                        onPressed: () {
                          Get.to(() => LoginView());
                        },
                      ),
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
