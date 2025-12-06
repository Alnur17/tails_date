import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class NewPasswordController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;

  final newTEController = TextEditingController();
  final confirmPasswordTEController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }


  Future resetPass({
    required String email,
    //required String password,
  })
  async {
    if (newTEController.text.trim() != confirmPasswordTEController.text.trim()) {
      kSnackBar(
          message: 'Password not match', bgColor: AppColors.orange);
      return;
    }
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;
      map['password'] = newTEController.text.trim();

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.resetPassword,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {

        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        Get.offAll(() => LoginView());

        isLoading(false);
      } else {
        throw 'Failed to login!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

}
