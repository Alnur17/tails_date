import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/model/all_category_model.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isCheckboxVisible = false.obs;
  var isLoading = false.obs;
  var categories = <Datum>[].obs;
  var selectedCategory = Rxn<Datum>();

  final petNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
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


      Get.off(() => DashboardView());
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
        kSnackBar(
          message: categoryModel.message ?? 'Categories loaded successfully!',
          bgColor: AppColors.green,
        );
      } else {
        kSnackBar(
          message: categoryModel.message ?? 'Failed to load categories',
          bgColor: AppColors.orange,
        );
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

  void setSelectedCategory(Datum? category) {
    selectedCategory.value = category;
  }
}