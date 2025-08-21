import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:tails_date/app/modules/signup/views/signup_view.dart';
import 'package:tails_date/common/widgets/custom_loader.dart';
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
    final LoginController loginController = Get.put(LoginController());
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
                    AppImages.loginImage,
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
                        'Login_Title'.tr,
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Login_Welcome'.tr,
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      CustomTextField(
                        controller: loginController.emailController,
                        hintText: 'Enter_Email'.tr,
                        preIcon: Image.asset(
                          AppImages.message,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      Obx(
                            () => CustomTextField(
                          controller: loginController.passwordController,
                          hintText: 'Enter_Password'.tr,
                          preIcon: Image.asset(
                            AppImages.lock,
                            scale: 4,
                          ),
                          sufIcon: GestureDetector(
                            onTap: () {
                              loginController.togglePasswordVisibility();
                            },
                            child: Image.asset(
                              loginController.isPasswordVisible.value
                                  ? AppImages.eye
                                  : AppImages.eyeClose,
                              scale: 4,
                            ),
                          ),
                          obscureText: !loginController.isPasswordVisible.value,
                        ),
                      ),
                      sh24,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ForgotPasswordView());
                        },
                        child: Text(
                          'Forgot_The_Password'.tr,
                          style: h4.copyWith(
                            color: AppColors.secondaryOrangeColor,
                          ),
                        ),
                      ),
                      sh16,
                      Obx(
                            () => loginController.isLoading.value
                            ? CustomLoader(color: AppColors.white)
                            : CustomButton(
                          text: 'Login_Button'.tr,
                          onPressed: () {
                            loginController.userLogin();
                          },
                        ),
                      ),
                      sh16,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SignupView());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'No_Account'.tr,
                              style: h4,
                              children: [
                                TextSpan(
                                  text: 'Sign_Up'.tr,
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