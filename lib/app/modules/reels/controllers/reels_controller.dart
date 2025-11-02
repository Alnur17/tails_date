import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_reels_model.dart';

class ReelsController extends GetxController {
  final RxList<Datum> reels = <Datum>[].obs;
  var likedReels = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final GetStorage storage = GetStorage();
  final userId = LocalStorage.getData(key: AppConstant.userId);

  @override
  void onInit() {
    super.onInit();
    loadLocalLikes();
    fetchReels();
  }

  /// Load Liked Posts from Local Storage
  void loadLocalLikes() {
    List<dynamic>? savedLikes = storage.read<List<dynamic>>('liked_reels');
    if (savedLikes != null) {
      likedReels.assignAll(savedLikes.map((id) => id.toString()).toList());
    }
  }

  /// Check if a Post is Liked
  bool isReelsLiked(String reelsId) {
    return likedReels.contains(reelsId);
  }

  /// Toggle Like (Local + API)
  Future<void> toggleLike(String reelsId) async {
    if (reelsId.isEmpty) {
      log("Error: Post ID is empty");
      return;
    }

    if (isReelsLiked(reelsId)) {
      likedReels.remove(reelsId); // Remove locally
    } else {
      likedReels.add(reelsId); // Add locally
    }

    // Save likes to GetStorage
    storage.write('liked_reels', likedReels.toList());
    likedReels.refresh();

    // Call API to sync like
    await addOrRemoveReactionFromReels(reelsId);
  }

  /// API: Add or Remove Like
  Future<void> addOrRemoveReactionFromReels(String reelsId) async {
    try {
      final token = LocalStorage.getData(key: AppConstant.token) ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.patchRequest(
        api: Api.addOrRemoveReelsReaction(reelsId),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        // update local post list instead of calling fetchPosts()
        final index = reels.indexWhere((p) => p.id == reelsId);
        if (index != -1) {
          if (isReelsLiked(reelsId)) {
            reels[index].reactions.add(userId ?? ""); // add actual userId
          } else {
            reels[index].reactions.remove(userId ?? "");
          }
          reels.refresh();
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

// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../data/api.dart';
// import '../../../data/base_client.dart';
// import '../model/all_reels_model.dart';
//
// class ReelsController extends GetxController {
//   final RxList<Datum> reels = <Datum>[].obs;
//   var likedReels = <String>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//   final GetStorage storage = GetStorage();
//   final userId = LocalStorage.getData(key: AppConstant.userId);
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadLocalLikes();
//     fetchReels();
//   }
//
//   // Load liked posts
//   void loadLocalLikes() {
//     List<dynamic>? savedLikes = storage.read<List<dynamic>>('liked_reels');
//     if (savedLikes != null) {
//       likedReels.assignAll(savedLikes.map((id) => id.toString()).toList());
//     }
//   }
//
//   bool isReelsLiked(String reelsId) {
//     return likedReels.contains(reelsId);
//   }
//
//   Future<void> toggleLike(String reelsId) async {
//     if (reelsId.isEmpty) return;
//
//     if (isReelsLiked(reelsId)) {
//       likedReels.remove(reelsId);
//     } else {
//       likedReels.add(reelsId);
//     }
//
//     storage.write('liked_reels', likedReels.toList());
//     likedReels.refresh();
//     await addOrRemoveReactionFromReels(reelsId);
//   }
//
//   Future<void> addOrRemoveReactionFromReels(String reelsId) async {
//     try {
//       final token = LocalStorage.getData(key: AppConstant.token) ?? '';
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//
//       final response = await BaseClient.patchRequest(
//         api: Api.addOrRemoveReelsReaction(reelsId),
//         headers: headers,
//       );
//
//       final result = jsonDecode(response.body);
//       if (result['success'] != true) {
//         print(result['message']);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> fetchReels() async {
//     try {
//       isLoading(true);
//       final token = LocalStorage.getData(key: AppConstant.token) ?? '';
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//
//       final response = await BaseClient.getRequest(
//         api: Api.allReels,
//         headers: headers,
//       );
//
//       final result = jsonDecode(response.body);
//       if (result['success'] == true) {
//         reels.assignAll(AllReelsModel.fromJson(result).data?.data ?? []);
//       } else {
//         errorMessage(result['message'] ?? 'Failed to load reels');
//       }
//     } catch (e) {
//       errorMessage(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Pass headers for protected videos
//   Map<String, String> getVideoHeaders() {
//     final token = LocalStorage.getData(key: AppConstant.token) ?? '';
//     return {
//       'Authorization': 'Bearer $token',
//     };
//   }
// }
