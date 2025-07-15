import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/my_friends_model.dart';

class MyFriendsController extends GetxController {
  var friendsList = <Datum>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final response = await BaseClient.getRequest(
        api: Api.friends,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if (result != null) {
        final friendsModel = MyFriendsModel.fromJson(result);
        if (friendsModel.success == true && friendsModel.data != null) {
          friendsList.assignAll(friendsModel.data!.data);
        } else {
          errorMessage.value = friendsModel.message ?? 'Failed to load friends';
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}