import 'package:flutter/material.dart';
import 'package:get/Get.dart';
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
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.signUpImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
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
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.black,
                      width: 4.0,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.mainColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sh16,
                      Text(
                        'Sign_Up'.tr,
                        style: h2,
                      ),
                      sh8,
                      Text(
                        'Fill_Your_Information'.tr,
                        style: h4.copyWith(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      sh24,
                      // Input fields
                      CustomTextField(
                        controller: signupController.petNameController,
                        hintText: 'Pet_Name'.tr,
                        preIcon: Image.asset(
                          AppImages.person,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      CustomTextField(
                        controller: signupController.emailController,
                        hintText: 'Enter_Email'.tr,
                        preIcon: Image.asset(
                          AppImages.message,
                          scale: 4,
                        ),
                      ),
                      sh16,
                      Obx(
                        () => CustomTextField(
                          controller: signupController.passwordController,
                          hintText: 'Enter_Password'.tr,
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
                          hintText: 'Confirm_Password'.tr,
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
                              hintText: 'Select_Category'.tr,
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
                                child: Text(category.name ?? 'Unknown'.tr),
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
                                ? Text('Loading_Categories'.tr)
                                : Text('Select_Category'.tr),
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
                            'By_Agreeing_To_The'.tr,
                            style: h5,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => TermsOfServicesView());
                              },
                              child: Text(
                                'Terms_And_Condition'.tr,
                                style: h4.copyWith(
                                    color: AppColors.secondaryOrangeColor),
                              ),
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
                                text: 'Sign_Up'.tr,
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
                              text: 'Already_Have_Account'.tr,
                              style: h4,
                              children: [
                                TextSpan(
                                  text: 'Log_In'.tr,
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
