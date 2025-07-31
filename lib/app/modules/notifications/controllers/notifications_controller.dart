import 'dart:convert';

import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../profile/model/friend_suggestions_model.dart';
import '../model/friend_req_model.dart';
import '../model/notification_model.dart';

class NotificationsController extends GetxController {
  var friendsSuggestionList = <FSuggestionsDatum>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  RxInt activeTab = 0.obs;

  void toggleTab(int tabIndex) {
    activeTab.value = tabIndex;
  }

  Future<NotificationModel> fetchNotifications() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final response = await BaseClient.getRequest(
        api: Api.notifications,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);
      return NotificationModel.fromJson(jsonResponse);
    } catch (e) {
      throw 'Failed to fetch notifications: $e';
    }
  }

  Future<FriendsReqModel> fetchFriendRequests() async {
    try {

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final response = await BaseClient.getRequest(
        api: Api.friendsRequests,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);
      return FriendsReqModel.fromJson(jsonResponse);
    } catch (e) {
      throw 'Failed to fetch friend requests: $e';
    }
  }

  Future<void> fetchFriendSuggestions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final response = await BaseClient.getRequest(
        api: Api.friendsSuggestions,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if (result != null) {
        final friendSuggestionsModel = FriendSuggestionsModel.fromJson(result);
        if (friendSuggestionsModel.success == true) {
          friendsSuggestionList.assignAll(friendSuggestionsModel.data);
        } else {
          errorMessage.value = friendSuggestionsModel.message ?? 'Failed to load friends';
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendFriendRequest(String receiverId) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final body = jsonEncode({"receiver": receiverId});
      final response = await BaseClient.postRequest(
        api: Api.addFriends,
        headers: headers,
        body: body,
      );

      await BaseClient.handleResponse(response);
      Get.snackbar("Success", "Friend request sent successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


}
