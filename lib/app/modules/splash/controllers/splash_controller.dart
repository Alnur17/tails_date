import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/free_trial/views/free_trial_view.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../auth_landing/views/auth_landing_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../onboarding/views/onboarding_view.dart';
import '../model/check_subscription_access_model.dart';

class SplashController extends GetxController {
  var checkSubscriptionAccess = Rx<CheckSubscriptionAccessModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;


  chooseScreen() async {
    var userToken = LocalStorage.getData(key: AppConstant.token);
    var onboardingDone = LocalStorage.getData(key: AppConstant.onboardingDone);

    if (userToken != null) {
      // Check subscription access before deciding
      await checkSubsAccess();

      if (checkSubscriptionAccess.value?.data?.hasAccess == true) {
        // User has active subscription → go to dashboard
        Get.offAll(
              () => DashboardView(),
          transition: Transition.rightToLeft,
        );
      } else {
        // User logged in but no subscription then go to freeTrial or subscribe
        Get.offAll(
              () => FreeTrialView(),
          transition: Transition.rightToLeft,
        );
      }
    } else {
      if (onboardingDone != null) {
        Get.offAll(
              () => AuthLandingView(),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.offAll(
              () => OnboardingView(),
          transition: Transition.rightToLeft,
        );
      }
    }
  }


  Future<void> checkSubsAccess() async {
    try {
      isLoading.value = true;
      final String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.checkSubscriptionAccess,
        headers: headers,
      );
      final responseData = await BaseClient.handleResponse(response);
      final checkSubscription =
      CheckSubscriptionAccessModel.fromJson(responseData);
      if (checkSubscription.success == true) {
        checkSubscriptionAccess.value = checkSubscription;
      } else {
        errorMessage.value = checkSubscription.message ??
            'Failed to load current subscription';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching current subscription: $e';
      debugPrint('Error: $e');
      if (e.toString().toLowerCase().contains('unauthorized')) {
        BaseClient.logout();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
