import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/guest_model.dart';

class AuthHomeController extends GetxController {
  var isLoading = false.obs;
  var guestPosts = <Datum>[].obs;
  var errorMessage = ''.obs;

  // Method to fetch guest posts
  Future<void> fetchGuestPosts() async {
    try {
      // Set loading state to true
      isLoading(true);

      // Make GET request using BaseClient
      final response = await BaseClient.getRequest(
        api: Api.guestPosts,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Handle response using BaseClient's handleResponse method
      final result = await BaseClient.handleResponse(response);

      // Parse response into GuestPostModel
      final guestPostModel = GuestPostModel.fromJson(result);

      if (guestPostModel.success == true && guestPostModel.data != null) {
        // Update guestPosts list with the fetched data
        guestPosts.assignAll(guestPostModel.data!.data);
      } else {
        errorMessage('No posts found');
      }
    } catch (e) {
      // Handle errors
      errorMessage(e.toString());
    } finally {
      // Set loading state to false
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // Fetch guest posts when controller is initialized
    fetchGuestPosts();
    super.onInit();
  }
}