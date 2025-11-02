import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../dashboard/views/dashboard_view.dart';

class FreeTrialController extends GetxController {
  var isLoading = false.obs;

  Future<void> startFreeTrial() async {
    try {
      isLoading.value = true;
      var token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.postRequest(
        api: Api.freeTrial,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if(result['success'] ==  true){
        Get.offAll(() => DashboardView());
      }else{
        kSnackBar(message: result['message'], bgColor: AppColors.red);
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
