import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class ReportController extends GetxController {
  final Map<String, RxBool> reasonOptions = {
    'Bullying, harassment or abuse': false.obs,
    'Violent, hateful or disturbing content': false.obs,
    'Block this user': false.obs,
    'Others Reason': false.obs,
  };
  final TextEditingController reasonController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  String getSelectedReason() {
    for (var entry in reasonOptions.entries) {
      if (entry.value.value && entry.key != 'Others Reason') {
        return entry.key;
      }
    }

    if (reasonOptions['Others Reason']!.value &&
        reasonController.text.isNotEmpty) {
      return reasonController.text;
    }

    throw "Please select a reason or provide a custom reason.";
  }

  Future<void> submitReport(String postId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final body = {
        "reason": getSelectedReason(),
        "post": postId,
      };
      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.postRequest(
        api: Api.reports,
        body: jsonEncode(body),
        headers: headers,
      );
      final result = await BaseClient.handleResponse(response);
      if (result != null) {
        _showThankYouPopup();
      } else {
        kSnackBar(message: 'Failed', bgColor: AppColors.red);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _showThankYouPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Thank you for your report!',
                style: Get.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'The content has been flagged for review. Admin will look into it and take appropriate action.',
                style:
                    Get.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Close',
                    style: Get.textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
