import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/model/all_category_model.dart';
import 'package:tails_date/app/modules/home/model/category_wise_post_model.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../profile/model/my_post_model.dart';
import '../model/all_post_model.dart';

class HomeController extends GetxController {
  var posts = <AllPostData>[].obs;
  var myPosts = <MyPostDatum>[].obs;
  var categoryWisePost = <CategoryWPostData>[].obs;
  var categories = <CategoryData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    //getCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategories();
    });
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

  // Future<void> createPosts({
  //   required String location,
  //   required String categoryId,
  //   required String caption,
  // })
  // async {try {
  //     isLoading.value = true;
  //     errorMessage.value = '';
  //
  //     String token = LocalStorage.getData(key: AppConstant.token);
  //
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };
  //
  //     // Prepare the form-data body as shown in the screenshot
  //     var request = http.MultipartRequest('POST', Uri.parse(Api.createPost));
  //     request.headers.addAll(headers);
  //
  //     // Add payload with dynamic data
  //     request.fields['payload'] = jsonEncode({
  //       "location": location,
  //       "category": categoryId,
  //       "caption": caption,
  //     });
  //
  //     final mimeType = lookupMimeType(image.path);
  //
  //     // Add images dynamically
  //     for (var imagePath in imagePaths) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'images',
  //         imagePath,
  //         contentType: MediaType.parse(mimeType),
  //       ));
  //     }
  //
  //     var response = await http.Response.fromStream(await request.send());
  //     final jsonResponse = await BaseClient.handleResponse(response);
  //
  //     if (jsonResponse['success'] == true) {
  //       kSnackBar(
  //         message: jsonResponse['message'] ?? 'Post created successfully',
  //         bgColor: AppColors.green,
  //       );
  //       await fetchPosts(); // Refresh posts after creating
  //     } else {
  //       errorMessage.value = jsonResponse['message'] ?? 'Failed to create post';
  //       kSnackBar(
  //         message: errorMessage.value,
  //         bgColor: AppColors.orange,
  //       );
  //     }
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     kSnackBar(
  //       message: errorMessage.value,
  //       bgColor: AppColors.orange,
  //     );
  //     log('Error creating post: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchMyPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.myPosts,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      final myPostModel = MyPostModel.fromJson(jsonResponse);

      if (myPostModel.success == true && myPostModel.data != null) {
        myPosts.assignAll(myPostModel.data!.data);
      } else {
        errorMessage.value = myPostModel.message ?? 'Failed to load my posts';
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
      log('Error fetching my posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryPosts({required String categoryId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String token = LocalStorage.getData(key: AppConstant.token);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.categoryPosts(categoryId),
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      final categoryWiseModel = CategoryWisePostModel.fromJson(jsonResponse);

      if (categoryWiseModel.success == true && categoryWiseModel.data != null) {
        categoryWisePost.assignAll(categoryWiseModel.data!.data);
      } else {
        errorMessage.value =
            categoryWiseModel.message ?? 'Failed to load category posts';
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

  Future<void> addOrRemoveReaction(String postId) async {
    try {
      final token = LocalStorage.getData(key: 'token') ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({'postId': postId});

      final response = await BaseClient.putRequest(
        api: Api.addOrRemoveReaction,
        body: body,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        kSnackBar(
          message:
              result['message']?.toString() ?? 'Reaction updated successfully',
          bgColor: AppColors.green,
        );
        await fetchPosts();
      } else {
        kSnackBar(
          message: result['message']?.toString() ?? 'Failed to update reaction',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.red,
      );
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
