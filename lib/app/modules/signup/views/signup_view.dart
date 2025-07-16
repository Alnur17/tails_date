import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/app/modules/terms_of_services/views/terms_of_services_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../home/model/all_category_model.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final SignupController signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.black,
                        width: 4.0,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    child: Image.asset(
                      AppImages.signUpImage,
                      fit: BoxFit.cover,
                    ),
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
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        controller: signupController.petNameController,
                        hintText: 'Pet Name',
                        preIcon: Image.asset(
                          AppImages.person,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      CustomTextField(
                        controller: signupController.emailController,
                        hintText: 'Enter your email',
                        preIcon: Image.asset(
                          AppImages.message,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      Obx(
                        () => CustomTextField(
                          controller: signupController.passwordController,
                          hintText: 'Enter your password',
                          preIcon: Image.asset(
                            AppImages.lock,
                            scale: 4,
                          ),
                          sufIcon: GestureDetector(
                            onTap: () {
                              signupController.togglePasswordVisibility();
                            },
                            child: Image.asset(
                              signupController.isPasswordVisible.value
                                  ? AppImages.eye
                                  : AppImages.eyeClose,
                              scale: 4,
                            ),
                          ),
                          obscureText:
                              !signupController.isPasswordVisible.value,
                        ),
                      ),
                      sh16,
                      Obx(
                        () => CustomTextField(
                          controller:
                              signupController.confirmPasswordController,
                          hintText: 'Confirm your password',
                          preIcon: Image.asset(
                            AppImages.lock,
                            scale: 4,
                          ),
                          sufIcon: GestureDetector(
                            onTap: () {
                              signupController.togglePasswordVisibility1();
                            },
                            child: Image.asset(
                              signupController.isPasswordVisible1.value
                                  ? AppImages.eye
                                  : AppImages.eyeClose,
                              scale: 4,
                            ),
                          ),
                          obscureText:
                              !signupController.isPasswordVisible1.value,
                        ),
                      ),
                      sh16,
                      Obx(
                        () => SizedBox(
                          height: 48,
                          child: DropdownButtonFormField<CategoryData>(
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              filled: true,
                              hintText: 'Select Category',
                              hintStyle: h4.copyWith(color: Colors.grey[700]),
                              suffixIcon: Image.asset(
                                AppImages.arrowDown,
                                scale: 4,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            value: signupController.selectedCategory.value,
                            items: signupController.categories
                                .map((CategoryData category) {
                              return DropdownMenuItem<CategoryData>(
                                value: category,
                                child: Text(category.name ?? 'Unknown'),
                              );
                            }).toList(),
                            onChanged: (CategoryData? newValue) {
                              signupController.setSelectedCategory(newValue);
                            },
                            isExpanded: true,
                            dropdownColor: AppColors.white,
                            icon: SizedBox.shrink(),
                            // Hide default dropdown icon
                            hint: signupController.isLoading.value
                                ? Text('Loading categories...')
                                : Text('Select Category'),
                          ),
                        ),
                      ),
                      sh24,
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: signupController.isCheckboxVisible.value,
                              onChanged: (value) {
                                signupController.toggleCheckboxVisibility();
                              },
                              activeColor: AppColors.black,
                            ),
                          ),
                          Text(
                            'By agreeing to the ',
                            style: TextStyle(color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => TermsOfServicesView());
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
                      Obx(
                        () => signupController.isLoading.value
                            ? CustomLoader(
                                color: AppColors.white,
                              )
                            : CustomButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  signupController.signup();
                                },
                              ),
                      ),
                      sh16,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => LoginView());
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
