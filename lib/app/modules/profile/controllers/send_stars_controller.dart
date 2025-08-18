import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class SendStarsController extends GetxController {
  RxInt selectedAmount = 0.obs;
  TextEditingController customAmountController = TextEditingController();

  //final HomeController homeController = Get.find();

  void selectAmount(int amount) {
    if (selectedAmount.value == amount) {
      // Deselect if the same amount is tapped again
      selectedAmount.value = 0;
      customAmountController.clear();
    } else {
      selectedAmount.value = amount;
      customAmountController.text = amount.toString();
    }
  }

  String getSelectedAmount() {
    return customAmountController.text;
  }

  Future<void> sendStars(String postId, int amount,BuildContext context) async {
    try {
      final token = LocalStorage.getData(key: 'token') ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'postId': postId,
        'stars': amount,
      });

      final response = await BaseClient.putRequest(
        api: Api.sendStars,
        body: body,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        kSnackBar(
          message: result['message']?.toString() ?? 'Send Stars successfully',
          bgColor: AppColors.green,
        );
        Navigator.pop(context);
        //await homeController.fetchPosts();
      } else {
        kSnackBar(
          message:
              result['message']?.toString() ?? 'Failed to update collection',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.red,
      );
    }
  }

  Future<void> sendStarsFromStory(
      String storyId, int amount, BuildContext context) async {
    try {
      final token = LocalStorage.getData(key: 'token') ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'storyId': storyId,
        'stars': amount,
      });

      final response = await BaseClient.postRequest(
        api: Api.sendStarsFromStory,
        body: body,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        kSnackBar(
          message: result['message']?.toString() ?? 'Send Stars successfully',
          bgColor: AppColors.green,
        );
        Navigator.pop(context);
      } else {
        kSnackBar(
          message:
              result['message']?.toString() ?? 'Failed to update collection',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.red,
      );
    }
  }

  @override
  void onClose() {
    customAmountController.dispose();
    super.onClose();
  }
}
