import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../login/views/login_view.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isPasswordVisible2 = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void togglePasswordVisibility2() {
    isPasswordVisible2.toggle();
  }

  @override
  void onInit() {
    super.onInit();
  }

  ///change password
  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      var map = {"oldPassword": currentPassword, "newPassword": newPassword};

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.changePassword, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        Get.offAll(() => LoginView());
        isLoading(false);
      } else {
        throw 'reset pass in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
