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
import '../model/my_profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Rx<MyProfileModel?>(null); // Store profile data

  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isPasswordVisible2 = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile(); // Fetch profile data when controller initializes
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void togglePasswordVisibility2() {
    isPasswordVisible2.toggle();
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Api.myProfile, headers: headers),
      );

      if (responseBody != null) {
        profileData.value = MyProfileModel.fromJson(responseBody);
        kSnackBar(message: profileData.value!.message ?? "Profile fetched successfully", bgColor: AppColors.green);
      } else {
        throw 'Failed to fetch profile!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error fetching profile: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
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
