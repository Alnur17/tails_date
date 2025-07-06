import 'package:get/get.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_reels_model.dart';

class ReelsController extends GetxController {
  final RxList<Datum> reels = <Datum>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  Future<void> fetchReels() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await BaseClient.getRequest(
        api: Api.allReels,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
        },
      );
      final result = await BaseClient.handleResponse(response);
      if (result !=null) {
        final allReelsModel = AllReelsModel.fromJson(result);
        if (allReelsModel.success == true && allReelsModel.data != null) {
          reels.assignAll(allReelsModel.data!.data);
        } else {
          errorMessage.value = allReelsModel.message ?? 'Failed to load reels';
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}