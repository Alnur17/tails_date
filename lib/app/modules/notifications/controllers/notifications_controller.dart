import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/friend_req_model.dart';
import '../model/notification_model.dart';

class NotificationsController extends GetxController {
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

}
