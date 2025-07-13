import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/conditions_model.dart';

class ConditionsController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var getAboutUs = ''.obs;
  var getTermsConditions = ''.obs;
  var getPrivacyPolicy = ''.obs;
  var conditionsModel = ConditionsModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchConditions();
  }

  Future<void> fetchConditions() async {
    try {
      isLoading(true);
      errorMessage('');

      String token = LocalStorage.getData(key: AppConstant.token) ?? '';
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.conditionsPage,
        headers: headers,
      );

      // Handle the response
      final data = await BaseClient.handleResponse(response);
      conditionsModel.value = ConditionsModel.fromJson(data);

      getPrivacyPolicy.value = conditionsModel.value.data!.privacyPolicy.toString();
      getTermsConditions.value = conditionsModel.value.data!.termsConditions.toString();
      getAboutUs.value = conditionsModel.value.data!.aboutUs.toString();

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

}
