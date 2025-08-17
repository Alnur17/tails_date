// import 'dart:async';
// import 'package:get/get.dart';
//
// class StoryController extends GetxController {
//   final currentIndex = 0.obs;
//   final progress = 0.0.obs;
//
//   Timer? _timer;
//
//   late final List<String> storyImageUrls;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     _startProgress();
//   }
//
//   void _startProgress() {
//     progress.value = 0.0;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       if (progress.value < 1.0) {
//         progress.value += 0.01; // Adjust this value to control speed
//       } else {
//         //goToNextStory(currentIndex);
//         _timer?.cancel();
//       }
//     });
//   }
//
//   void goToNextStory(storyImageUrls) {
//     if (currentIndex.value < storyImageUrls.length - 1) {
//       currentIndex.value++;
//       _startProgress();
//     } else {
//       Get.back();
//     }
//   }
//
//   void goToPreviousStory() {
//     if (currentIndex.value > 0) {
//       currentIndex.value--;
//       _startProgress();
//     } else {
//       Get.back();
//     }
//   }
//
//   void resetProgress() {
//     _timer?.cancel();
//     _startProgress();
//   }
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }


import 'dart:developer';
import 'dart:async';
import 'package:get/get.dart';
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/app/data/base_client.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../model/all_author_story_model.dart';
import '../model/author_story_by_id_model.dart';



class StoryController extends GetxController {
  final currentIndex = 0.obs;
  final progress = 0.0.obs;
  final storyAuthors = Rx<AllAuthorStoryModel?>(null);
  final storyImageUrls = RxList<String>([]);
  final authorStories = Rx<GetAuthorStoryByIdModel?>(null);
  final isLoadingAuthors = true.obs;
  final isLoadingStories = false.obs;
  final isLoading = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchStoryAuthors();
    _startProgress();
  }

  void _startProgress() {
    progress.value = 0.0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress.value < 1.0) {
        progress.value += 0.01; // Adjust this value to control speed
      } else {
        _timer?.cancel();
      }
    });
  }

  void goToNextStory() {
    if (currentIndex.value < storyImageUrls.length - 1) {
      currentIndex.value++;
      _startProgress();
    } else {
      Get.back();
    }
  }

  void goToPreviousStory() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      _startProgress();
    } else {
      Get.back();
    }
  }

  void resetProgress() {
    _timer?.cancel();
    _startProgress();
  }

  Future<void> fetchStoryAuthors() async {
    try {
      isLoadingAuthors.value = true;
      final response = await BaseClient.getRequest(
        api: Api.allAuthorStory,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${await LocalStorage.getData(key: AppConstant.token)}',
        },
      );
      final result = await BaseClient.handleResponse(response);
      storyAuthors.value = AllAuthorStoryModel.fromJson(result);
      log('fetchStoryAuthors: ${storyAuthors.value?.data}');
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
    } finally {
      isLoadingAuthors.value = false;
    }
  }

  Future<void> fetchStoriesByAuthor(String authorId) async {
    try {
      isLoadingStories.value = true;
      final response = await BaseClient.getRequest(
        api: Api.getAuthorStoriesById(authorId),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${await LocalStorage.getData(key: AppConstant.token)}',
        },
      );
      final result = await BaseClient.handleResponse(response);
      log('fetchStoriesByAuthor response: $result');
      authorStories.value = GetAuthorStoryByIdModel.fromJson(result);
      storyImageUrls.value = authorStories.value!.data
          .where((story) => story.image != null && story.image!.isNotEmpty)
          .map((story) => story.image!)
          .toList();
      log('storyImageUrls: ${storyImageUrls.value}');
      currentIndex.value = 0;
      resetProgress();
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.orange);
      log('fetchStoriesByAuthor error: $e');
    } finally {
      isLoadingStories.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
