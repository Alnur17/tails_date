import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/star_plan_model.dart';
import '../views/payment_view.dart';

class BuyStarController extends GetxController {
  var isLoading = true.obs;
  var starPlans = <StarPlanData>[].obs;
  var selectedPlanIndex = (-1).obs; // Tracks the selected plan index, -1 means none selected
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
      message: 'Initiating purchase for ${selectedPlan.stars} Stars at \$${selectedPlan.price?.toStringAsFixed(2)}',
      bgColor: AppColors.green,
    );
    createPaymentSessionForStar(starPlanId: selectedPlan.id!);
  }
}