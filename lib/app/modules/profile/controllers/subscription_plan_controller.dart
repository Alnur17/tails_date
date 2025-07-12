import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/base_client.dart';
import '../model/my_current_subscriptions_model.dart';
import '../model/subscription_plan_model.dart';
import '../views/payment_success_view.dart';
import '../views/payment_view.dart';

class SubscriptionPlanController extends GetxController {
  var subscriptionPlans = <SubscriptionPlanData>[].obs;
  var myCurrentSubscription = Rx<MyCurrentSubscriptionModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlans();
    fetchMyCurrentSubscription();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;
      final String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.subscriptionPlan,
        headers: headers,
      );
      final responseData = await BaseClient.handleResponse(response);
      final subscriptionPlanModel =
          SubscriptionPlanModel.fromJson(responseData);
      if (subscriptionPlanModel.success == true) {
        subscriptionPlans.assignAll(subscriptionPlanModel.data);
      } else {
        errorMessage.value = subscriptionPlanModel.message ??
            'Failed to load subscription plans';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching subscription plans: $e';
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyCurrentSubscription() async {
    try {
      isLoading.value = true;
      final String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.myCurrentSubscriptionPlan,
        headers: headers,
      );
      final responseData = await BaseClient.handleResponse(response);
      final currentSubscription =
      MyCurrentSubscriptionModel.fromJson(responseData);
      if (currentSubscription.success == true) {
        myCurrentSubscription.value = currentSubscription;
      } else {
        errorMessage.value = currentSubscription.message ??
            'Failed to load current subscription';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching current subscription: $e';
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPaymentSession({
    required String subscriptionId,
  })
  async {
    isLoading.value = true;
    String token = LocalStorage.getData(key: AppConstant.token);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };


    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.buySubscriptionPlan(subscriptionId),
        headers: headers,
      ),
    );

    if (responseBody != null) {
      Get.to(() => PaymentView(paymentUrl: responseBody["data"]["url"]));
      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }


  Future<void> paymentResults({required String paymentLink}) async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response =
      await BaseClient.getRequest(api: paymentLink, headers: headers);

      var responseBody = await BaseClient.handleResponse(response);

      if (responseBody['success'] == true) {

        Get.offAll(() => PaymentSuccessView());
      } else {
        debugPrint("Error on Payment Result: $responseBody['message'] ");
      }
    } catch (e) {
      debugPrint("Error on Payment Result: $e");
      kSnackBar(
        message: "Error on Payment Result: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

}
