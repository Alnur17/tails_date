import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/model/all_category_model.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_post_model.dart';

class HomeController extends GetxController {
  var posts = <AllPostData>[].obs;
  var categories = <CategoryData>[].obs;
  var isLoading = false.obs; // Loading state
  var errorMessage = ''.obs; // Error message

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    getCategories();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.allPosts,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      final allPostModel = AllPostModel.fromJson(jsonResponse);

      if (allPostModel.success == true && allPostModel.data != null) {
        posts.assignAll(allPostModel.data!.data);
      } else {
        errorMessage.value = allPostModel.message ?? 'Failed to load posts';
        kSnackBar(
          message: errorMessage.value,
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      kSnackBar(
        message: errorMessage.value,
        bgColor: AppColors.orange,
      );
      log('Error fetching posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      String accessToken = LocalStorage.getData(key: AppConstant.token);
      debugPrint(accessToken);
      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.getCategory,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      final categoryModel = AllCategoryModel.fromJson(result);

      if (categoryModel.success == true) {
        categories.assignAll(categoryModel.data);
        debugPrint('Categories loaded successfully!');
      } else {
        debugPrint('Failed to load categories');
        // kSnackBar(
        //   message: categoryModel.message ?? 'Failed to load categories',
        //   bgColor: AppColors.orange,
        // );
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
