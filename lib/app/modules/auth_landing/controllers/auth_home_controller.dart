import 'package:get/get.dart';
import 'package:tails_date/app/modules/auth_landing/model/guest_model.dart';
import 'package:tails_date/app/modules/auth_landing/views/guest_home_view.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/auth_landing_view.dart';

class AuthHomeController extends GetxController {
  var isGuest = false.obs;
  var isLoading = false.obs;
  var guestPosts = <GuestPostDatum>[].obs;
  var errorMessage = ''.obs;

  void continueAsGuest() {
    isGuest.value = true;
    Get.offAll(() => GuestHomeView()); // replace stack so they can’t go back to auth
  }

  void logout() {
    isGuest.value = false;
    Get.offAll(() => AuthLandingView());
  }


  Future<void> fetchGuestPosts() async {
    try {

      isLoading(true);

      final response = await BaseClient.getRequest(
        api: Api.guestPosts,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final result = await BaseClient.handleResponse(response);

      final guestPostModel = GuestPostModel.fromJson(result);

      if (guestPostModel.success == true && guestPostModel.data != null) {
        guestPosts.assignAll(guestPostModel.data!.data);
      } else {
        errorMessage('No posts found');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchGuestPosts();
    super.onInit();
  }


  String formatTimeAgo(DateTime? createdAt) {
    if (createdAt == null) return 'Unknown time';
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

}