import 'package:get/get.dart';
import 'package:tails_date/app/data/base_client.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../model/send_and_received_stars_model.dart';

class SendAndReceivedStarsController extends GetxController {
  var receivedStars = <SARStarsDatum>[].obs;
  var sentStars = <SARStarsDatum>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReceivedStars();
    fetchSentStars();
  }

  Future<void> fetchReceivedStars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await LocalStorage.getData(key: AppConstant.token);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.receivedStarsHistory,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      final starsModel = SendAndReceivedStarsModel.fromJson(result);
      receivedStars.assignAll(starsModel.data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSentStars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await LocalStorage.getData(key: AppConstant.token);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.sendStarsHistory,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      final starsModel = SendAndReceivedStarsModel.fromJson(result);
      sentStars.assignAll(starsModel.data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}