import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/forgot_password/views/verify_otp_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/new_password_view.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  Rx<int> countdown = 59.obs;

  final emailTEController = TextEditingController();
  final otpTEController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  // Countdown timer logic
  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  ///forgot Password Controller
  Future forgotPassword({
    required String email,
  }) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.forgotPassword,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);
        Get.to(() => VerifyOtpView(email),transition: Transition.fade);

        isLoading(false);
      } else {
        throw 'forgot in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  Future verifyOtp({
    required String email,
    required String otp,
  })
  async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;
      map['otp'] = otp;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.otpVerify,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {

        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        Get.to(() => NewPasswordView(email));

        isLoading(false);
      } else {
        throw 'verify otp in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }


}
