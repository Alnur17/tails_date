import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../profile/model/friend_suggestions_model.dart';
import '../model/friend_req_model.dart';
import '../model/notification_model.dart';

class NotificationsController extends GetxController {
  final searchController = TextEditingController();
  var friendsSuggestionList = <FSuggestionsDatum>[].obs;
  var filteredFriendsSuggestionList = <FSuggestionsDatum>[].obs; // New filtered list
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  RxInt activeTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFriendSuggestions();
    // Add listener to searchController for real-time filtering
    searchController.addListener(_filterFriends);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleTab(int tabIndex) {
    activeTab.value = tabIndex;
  }

  // Filter friends based on search query
  void _filterFriends() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredFriendsSuggestionList.assignAll(friendsSuggestionList);
    } else {
      filteredFriendsSuggestionList.assignAll(
        friendsSuggestionList.where((friend) =>
            friend.name!.toLowerCase().contains(query)).toList(),
      );
    }
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
          filteredFriendsSuggestionList.assignAll(friendSuggestionsModel.data); // Initialize filtered list
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

      // After sending a request, fetch updated data
      await fetchFriendSuggestions();
      update(); // Force UI refresh
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateFriendRequest(String requestId, String status) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final body = jsonEncode({
        "friendRequestId": requestId,
        "status": status,
      });

      final response = await BaseClient.patchRequest(
        api: Api.updateFriendsRequests,
        headers: headers,
        body: body,
      );

      await BaseClient.handleResponse(response);
      Get.snackbar("Success", "Friend request $status successfully");

      // Fetch updated friend requests and update the UI
      await fetchFriendRequests(); // This will update the list
      update(); // Force UI refresh
    } catch (e) {
      Get.snackbar("Error", "Failed to update friend request: $e");
    }
  }

  Future<void> deleteSendRequest(String requestId) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      final response = await BaseClient.deleteRequest(
        api: Api.deleteSendRequests(requestId),
        headers: headers,
      );

      await BaseClient.handleResponse(response);
      Get.snackbar("Success", "Friend request deleted successfully");

      // Fetch updated friend requests and update the UI
      await fetchFriendRequests();
      update(); // Force UI refresh
    } catch (e) {
      Get.snackbar("Error", "Failed to update friend request: $e");
    }
  }
}
