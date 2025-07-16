import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/app/modules/signup/views/verify_account_view.dart';
import '../../../../common/app_color/app_colors.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCategories();
    });
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void togglePasswordVisibility1() => isPasswordVisible1.toggle();
  void toggleCheckboxVisibility() => isCheckboxVisible.toggle();

  Future<void> signup() async {
    if (petNameController.text.trim().isEmpty) {
      kSnackBar(message: 'Please enter a pet name', bgColor: AppColors.orange);
      return;
    }

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

    if (selectedCategory.value == null || selectedCategory.value?.name == null || selectedCategory.value!.name!.isEmpty) {
      kSnackBar(message: 'Please select a valid category', bgColor: AppColors.orange);
      return;
    }

    if (!isCheckboxVisible.value) {
      kSnackBar(message: 'Please agree to the Terms & Conditions', bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        'name': petNameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'category': selectedCategory.value!.name!,
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.signup,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      debugPrint('Signup response: $result');

      kSnackBar(
        message: result['message']?.toString() ?? 'Signup successful!',
        bgColor: AppColors.green,
      );

      Get.to(() => VerifyAccountView(emailController.text.trim()));
    } catch (e, stack) {
      debugPrint('Signup error: $e');
      debugPrint('Stack trace: $stack');
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> accountVerification(String email) async {
    if (otpController.text.isEmpty) {
      kSnackBar(message: 'Please enter the OTP', bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        'email': email,
        'otp': otpController.text,
        'verify_account': true,
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.verifyAccount,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      debugPrint('Verify response: $result');

      kSnackBar(
        message: result['message']?.toString() ?? 'Verification successful!',
        bgColor: AppColors.green,
      );

      Get.offAll(() => LoginView());
    } catch (e, stack) {
      debugPrint('Verification error: $e');
      debugPrint('Stack trace: $stack');
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.getRequest(
        api: Api.getCategory,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      debugPrint('Categories response: $result');

      final categoryModel = AllCategoryModel.fromJson(result);

      if (categoryModel.success == true) {
        categories.assignAll(categoryModel.data);
        debugPrint('Categories loaded successfully!');
      } else {
        kSnackBar(
          message: categoryModel.message?.toString() ?? 'Failed to load categories',
          bgColor: AppColors.orange,
        );
      }
    } catch (e, stack) {
      debugPrint('Fetch categories error: $e');
      debugPrint('Stack trace: $stack');
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCategory(CategoryData? category) {
    selectedCategory.value = category;
  }
}
