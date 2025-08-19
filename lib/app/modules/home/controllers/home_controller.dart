import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tails_date/app/modules/home/model/all_category_model.dart';
import 'package:tails_date/app/modules/home/model/category_wise_post_model.dart';
import 'package:tails_date/app/modules/profile/controllers/collections_controller.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import 'package:tails_date/common/widgets/custom_snack_bar.dart';
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/app/data/base_client.dart';
import 'package:tails_date/app/modules/profile/model/my_post_model.dart';
import 'package:tails_date/app/modules/home/model/all_post_model.dart';

class HomeController extends GetxController {
  var posts = <AllPostData>[].obs;
  var myPosts = <MyPostDatum>[].obs;
  var categoryWisePost = <CategoryWPostData>[].obs;
  var categories = <CategoryData>[].obs;
  var likedPosts = <String>[].obs; // Store liked post IDs locally
  var savedCollections = <String>[].obs; // Store collection-saved post IDs locally
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final userId = LocalStorage.getData(key: AppConstant.userId);
  final GetStorage storage = GetStorage(); // Initialize GetStorage

  final collectionController = Get.put(CollectionsController());

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    loadLocalLikes(); // Load liked posts from local storage
    loadLocalCollections(); // Load saved collections from local storage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategories();
    });
  }

  /// Load Liked Posts from Local Storage
  void loadLocalLikes() {
    List<dynamic>? savedLikes = storage.read<List<dynamic>>('liked_posts');
    if (savedLikes != null) {
      likedPosts.assignAll(savedLikes.map((id) => id.toString()).toList());
    }
  }

  /// Load Saved Collections from Local Storage
  void loadLocalCollections() {
    List<dynamic>? savedCollections = storage.read<List<dynamic>>('saved_collections');
    if (savedCollections != null) {
      savedCollections.assignAll(savedCollections.map((id) => id.toString()).toList());
    }
  }

  /// Check if a Post is Liked
  bool isPostLiked(String postId) {
    return likedPosts.contains(postId);
  }

  /// Check if a Post is Saved in Collections
  bool isPostInCollections(String postId) {
    return savedCollections.contains(postId);
  }

  /// Toggle Like (Local + API)
  Future<void> toggleLike(String postId) async {
    if (postId.isEmpty) {
      log("Error: Post ID is empty");
      return;
    }

    if (isPostLiked(postId)) {
      likedPosts.remove(postId); // Remove locally
    } else {
      likedPosts.add(postId); // Add locally
    }

    // Save likes to GetStorage
    storage.write('liked_posts', likedPosts.toList());
    likedPosts.refresh();

    // Call API to sync like
    await addOrRemoveReaction(postId);
  }


  /// Toggle Collection Save (Local + API)
  Future<void> toggleCollection(String postId) async {
    if (postId.isEmpty) {
      log("Error: Post ID is empty");
      return;
    }

    // ✅ Optimistic update (local only first)
    if (isPostInCollections(postId)) {
      savedCollections.remove(postId);
    } else {
      savedCollections.add(postId);
    }

    storage.write('saved_collections', savedCollections.toList());
    savedCollections.refresh();

    // Let CollectionsController handle API & internal sync
    await collectionController.addOrRemoveCollection(postId);
  }


  /// API: Add or Remove Like
  Future<void> addOrRemoveReaction(String postId) async {
    try {
      final token = LocalStorage.getData(key: AppConstant.token) ?? '';
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
        // ✅ update local post list instead of calling fetchPosts()
        final index = posts.indexWhere((p) => p.id == postId);
        if (index != -1) {
          if (isPostLiked(postId)) {
            posts[index].reactions.add(userId ?? ""); // add actual userId
          } else {
            posts[index].reactions.remove(userId ?? "");
          }
          posts.refresh();
        }

        final myPostIndex = myPosts.indexWhere((p) => p.id == postId);
        if (myPostIndex != -1) {
          if (isPostLiked(postId)) {
            myPosts[myPostIndex].reactions.add(userId ?? "");
          } else {
            myPosts[myPostIndex].reactions.remove(userId ?? "");
          }
          myPosts.refresh(); // Trigger UI update for myPosts
        }

        final categoryWisePostsIndex = categoryWisePost.indexWhere((p) => p.id == postId);
        if (categoryWisePostsIndex != -1) {
          if (isPostLiked(postId)) {
            categoryWisePost[categoryWisePostsIndex].reactions.add(userId ?? "");
          } else {
            categoryWisePost[categoryWisePostsIndex].reactions.remove(userId ?? "");
          }
          categoryWisePost.refresh(); // Trigger UI update for myPosts
        }

        kSnackBar(
          message: result['message']?.toString() ?? 'Reaction updated successfully',
          bgColor: AppColors.green,
        );
      } else {
        kSnackBar(
          message: result['message']?.toString() ?? 'Failed to update reaction',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: 'Error updating reaction: $e',
        bgColor: AppColors.red,
      );
      log('Error updating reaction: $e');
    }
  }

  Future<void> fetchPosts() async {
    try {
      //if (myPosts.isNotEmpty) return;
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

  Future<void> addNotInterested(String userId, postId) async {
    try {
      final token = LocalStorage.getData(key: AppConstant.token);

      var decodedToken = JwtDecoder.decode(token);
      final String? userId = decodedToken['id']?.toString();

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {"postId": postId, "userId": userId};

      var response = await BaseClient.putRequest(
        api: Api.addNotInterested,
        headers: headers,
        body: jsonEncode(body),
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        await fetchPosts();
      }
    } catch (e) {
      return debugPrint("$e");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      isLoading.value = true;
      final token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final responseBody = await BaseClient.deleteRequest(
        api: Api.deletePost(postId),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(responseBody);

      if (result['success'] == true) {
        fetchPosts();
      } else {
        debugPrint('Failed to delete my posts');
      }
    } catch (e) {
      return debugPrint("$e");
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