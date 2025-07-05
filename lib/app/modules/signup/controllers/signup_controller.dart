import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/app/modules/signup/views/verify_account_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../home/model/all_category_model.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isCheckboxVisible = false.obs;
  var isLoading = false.obs;
  var categories = <CategoryData>[].obs;
  var selectedCategory = Rxn<CategoryData>();

  final petNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void toggleCheckboxVisibility() {
    isCheckboxVisible.toggle();
  }

  Future<void> signup() async {
    if (petNameController.text.trim().isEmpty) {
      kSnackBar(message: 'Please enter a pet name', bgColor: AppColors.orange);
      return;
    }
    //if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
    if (emailController.text.trim().isEmpty) {
      kSnackBar(message: 'Please enter a valid email', bgColor: AppColors.orange);
      return;
    }
    if (passwordController.text.trim().isEmpty || passwordController.text.length < 7) {
      kSnackBar(message: 'Password must be at least 7 characters', bgColor: AppColors.orange);
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      kSnackBar(message: 'Passwords do not match', bgColor: AppColors.orange);
      return;
    }
    if (selectedCategory.value == null) {
      kSnackBar(message: 'Please select a category', bgColor: AppColors.orange);
      return;
    }
    if (!isCheckboxVisible.value) {
      kSnackBar(message: 'Please agree to the Terms & Conditions', bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      var body = {
        'name': petNameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'category': selectedCategory.value!.name,
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.postRequest(
        api: Api.signup,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      kSnackBar(
        message: result['message'] ?? 'Signup successful!',
        bgColor: AppColors.green,
      );

      Get.to(() => VerifyAccountView(emailController.text.trim()));
      isLoading.value = false;
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> accountVerification(String email) async {

    if (otpController.text.isEmpty) {
      kSnackBar(message: 'Please enter the otp', bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      var body = {
        'email': email,
        'otp': otpController.text,
        'verify_account': true,
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.postRequest(
        api: Api.verifyAccount,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      kSnackBar(
        message: result['message'] ?? 'Verify successful!',
        bgColor: AppColors.green,
      );

      Get.offAll(() => LoginView());
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      String accessToken = LocalStorage.getData(key: AppConstant.token);
      debugPrint(accessToken);
      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.getCategory,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      final categoryModel = AllCategoryModel.fromJson(result);

      if (categoryModel.success == true) {
        categories.assignAll(categoryModel.data);
        debugPrint('Categories loaded successfully!');
      } else {
        debugPrint('Failed to load categories');
        // kSnackBar(
        //   message: categoryModel.message ?? 'Failed to load categories',
        //   bgColor: AppColors.orange,
        // );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCategory(CategoryData? category) {
    selectedCategory.value = category;
  }
}