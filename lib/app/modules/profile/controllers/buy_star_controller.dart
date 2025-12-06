import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/cashout_status_model.dart';
import '../model/star_plan_model.dart';
import '../views/payment_view.dart';

class BuyStarController extends GetxController {
  var isLoading = true.obs;
  var starPlans = <StarPlanData>[].obs;
  var cashOutStatusList = <CashOutStatusDatum>[].obs; // Added to store cash-out status data
  var selectedPlanIndex = (-1).obs;
  TextEditingController cashOutTEController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchStarPlans();
  }

  Future<void> fetchStarPlans() async {
    try {
      isLoading(true);

      var token = LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.starPlans,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      final result = await BaseClient.handleResponse(response);
      final starPlanModel = StarPlanModel.fromJson(result);
      if (starPlanModel.success == true) {
        starPlans.assignAll(starPlanModel.data);
      } else {
        kSnackBar(
          message: starPlanModel.message ?? 'Failed to load star plans',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPaymentSessionForStar({
    required String starPlanId,
  }) async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.buyStarPlan(starPlanId),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        Get.to(() => PaymentView(paymentUrl: responseBody["data"]["url"]));
      } else {
        Get.snackbar("Error", "Failed to create payment session");
      }
    } catch (e) {
      debugPrint("Error, Failed to create payment $e");
      kSnackBar(
        message: 'Failed to initiate payment: $e',
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }

  void buySelectedPlan() {
    if (selectedPlanIndex.value == -1) {
      kSnackBar(
        message: 'Please select a star plan',
        bgColor: AppColors.orange,
      );
      return;
    }
    final selectedPlan = starPlans[selectedPlanIndex.value];
    kSnackBar(
      message:
      'Initiating purchase for ${selectedPlan.stars} Stars at \$${selectedPlan.price?.toStringAsFixed(2)}',
      bgColor: AppColors.green,
    );
    createPaymentSessionForStar(starPlanId: selectedPlan.id!);
  }

  Future<void> casOutRequest(context, int amount) async {
    try {
      isLoading.value = true;
      var token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = {"stars": amount * 100, "amount": amount};

      dynamic responseBody = await BaseClient.postRequest(
        api: Api.cashOut,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(responseBody);

      if (result['success'] == true) {
        showSubmitRequestDialog(context);
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future showSubmitRequestDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "CashOut Request Submitted",
      titlePadding: EdgeInsets.only(top: 16),
      backgroundColor: AppColors.white,
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "You've requested to cash out \$${cashOutTEController.text.trim()} . Processing will be done when approved.",
              style: h4.copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sh20,
          CustomButton(
            text: 'Close ',
            onPressed: () {
              Get.offAll(() => DashboardView());
            },
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Future<void> getCashOutStatus() async {
    try {
      isLoading.value = true;
      var token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.cashOutStatus,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      final cashOutStatusModel = CashOutStatusModel.fromJson(result);

      if (cashOutStatusModel.success == true) {
        cashOutStatusList.assignAll(cashOutStatusModel.data);
        debugPrint('CashOut Status fetched successfully: ${cashOutStatusList.length} records');
      } else {
        kSnackBar(
          message: cashOutStatusModel.message ?? 'Failed to fetch cash-out status',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      debugPrint("Error fetching cash-out status: $e");
      kSnackBar(
        message: 'Failed to fetch cash-out status: $e',
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
}