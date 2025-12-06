import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../dashboard/views/dashboard_view.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> userLogin() async {
    if (emailController.text.trim().isEmpty) {
      kSnackBar(
          message: 'Please enter a valid email', bgColor: AppColors.orange);
      return;
    }
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 7) {
      kSnackBar(
          message: 'Password must be at least 7 characters',
          bgColor: AppColors.orange);
      return;
    }

    try {
      isLoading.value = true;

      String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);

      var body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'fcm_token': fcmToken,
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.postRequest(
        api: Api.login,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if (result != null) {
        final String token = result['data']['accessToken'].toString();
        LocalStorage.saveData(key: AppConstant.token, data: token);
        String accessToken = LocalStorage.getData(key: AppConstant.token);
        debugPrint(accessToken);
        kSnackBar(
          message: result['message'] ?? 'Login successful!',
          bgColor: AppColors.green,
        );
        Get.offAll(() => DashboardView());
      } else {
        kSnackBar(message: result['message'], bgColor: AppColors.red);
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
}
