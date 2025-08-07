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
//   //
//   // StoryController(this.storyImageUrls);
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


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_stories_model.dart';
import '../model/my_story_model.dart';

class StoryController extends GetxController {
  var stories = <AllStoryDatum>[].obs; // For getAllStory
  var myStories = <MyStoryDatum>[].obs; // For myStory
  var currentIndex = 0.obs;
  var progress = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllStories();
    fetchMyStories();
    startProgress();
  }

  void startProgress() {
    progress.value = 0.0;
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 100));
      progress.value += 0.02;
      if (progress.value >= 1.0) {
        goToNextStory();
        return false;
      }
      return true;
    });
  }

  void goToPreviousStory() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      progress.value = 0.0;
      startProgress();
    }
  }

  void goToNextStory() {
    if (currentIndex.value < stories.length - 1) {
      currentIndex.value++;
      progress.value = 0.0;
      startProgress();
    } else {
      Get.back();
    }
  }

  Future<void> fetchAllStories() async {
    try {
      isLoading.value = true;
      final token = await LocalStorage.getData(key: 'token');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      debugPrint('Fetching all stories from ${Api.getAllStory}');
      final response = await BaseClient.getRequest(
        api: Api.getAllStory,
        headers: headers,
      ).timeout(Duration(seconds: 30));
      final data = await BaseClient.handleResponse(response);
      debugPrint('getAllStory response: ${response.statusCode} - ${response.body}');
      final allStoriesModel = AllStoriesModel.fromJson(data);
      if (allStoriesModel.success == true && allStoriesModel.data != null) {
        stories.value = allStoriesModel.data!.data.where((story) => story.isDeleted != true).toList();
        debugPrint('Fetched ${stories.length} stories from getAllStory, last caption: ${stories.lastOrNull?.caption}');
      } else {
        Get.snackbar('Error', allStoriesModel.message ?? 'Failed to fetch all stories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch all stories: $e');
      debugPrint('fetchAllStories error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyStories() async {
    try {
      final token = await LocalStorage.getData(key: 'token');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      debugPrint('Fetching my stories from ${Api.myStory}');
      final response = await BaseClient.getRequest(
        api: Api.myStory,
        headers: headers,
      ).timeout(Duration(seconds: 30));
      final data = await BaseClient.handleResponse(response);
      debugPrint('myStory response: ${response.statusCode} - ${response.body}');
      final myStoryModel = MyStoryModel.fromJson(data);
      if (myStoryModel.success == true && myStoryModel.data != null) {
        myStories.value = myStoryModel.data!.data.where((story) => story.isDeleted != true).toList();
        debugPrint('Fetched ${myStories.length} stories from myStory, last caption: ${myStories.lastOrNull?.caption}');
      } else {
        Get.snackbar('Error', myStoryModel.message ?? 'Failed to fetch my stories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch my stories: $e');
      debugPrint('fetchMyStories error: $e');
    }
  }

  Future<void> createStory({
    required String mediaPath,
    String? caption,
    int retries = 2,
  }) async {
    for (int attempt = 0; attempt <= retries; attempt++) {
      try {
        isLoading.value = true;
        caption = caption?.trim() ?? ""; // Ensure caption is included, default to empty string
        debugPrint('Attempt ${attempt + 1} to create story with mediaPath: $mediaPath, caption: "$caption"');
        final token = await LocalStorage.getData(key: 'token');
        var request = http.MultipartRequest('POST', Uri.parse(Api.createStory));
        request.headers['Authorization'] = 'Bearer $token';
        String? mimeType = lookupMimeType(mediaPath);
        debugPrint('Detected MIME type: $mimeType');
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            mediaPath,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );
        request.fields['payload'] = caption; // Always include caption field
        debugPrint('Payload fields: ${request.fields}');
        final streamedResponse = await request.send().timeout(Duration(seconds: 90));
        final response = await http.Response.fromStream(streamedResponse);
        debugPrint('createStory response: ${response.statusCode} - ${response.body}');
        await BaseClient.handleResponse(response);
        debugPrint('Story created successfully, refreshing stories');
        await Future.wait([
          fetchAllStories(),
          fetchMyStories(),
        ]);
        Get.snackbar('Success', 'Story created successfully with caption: "$caption"');
        return; // Exit on success
      } catch (e) {
        if (attempt < retries) {
          debugPrint('Retrying createStory due to error: $e');
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
        Get.snackbar('Error', 'Failed to create story after $retries retries: $e');
        debugPrint('createStory error after retries: $e');
        // Fallback: Refresh stories even on failure to ensure UI updates
        await Future.wait([
          fetchAllStories(),
          fetchMyStories(),
        ]);
      } finally {
        isLoading.value = false;
        debugPrint('createStory completed, isLoading: ${isLoading.value}');
      }
    }
  }
}

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
// import '../../../../../common/helper/local_store.dart';
// import '../../../data/api.dart';
// import '../../../data/base_client.dart';
// import '../model/my_story_model.dart';
//
// class StoryController extends GetxController {
//   var stories = <MyStoryDatum>[].obs;
//   var currentIndex = 0.obs;
//   var progress = 0.0.obs;
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchMyStories();
//     startProgress();
//   }
//
//   void startProgress() {
//     progress.value = 0.0;
//     Future.doWhile(() async {
//       await Future.delayed(Duration(milliseconds: 100));
//       progress.value += 0.02;
//       if (progress.value >= 1.0) {
//         goToNextStory();
//         return false;
//       }
//       return true;
//     });
//   }
//
//   void goToPreviousStory() {
//     if (currentIndex.value > 0) {
//       currentIndex.value--;
//       progress.value = 0.0;
//       startProgress();
//     }
//   }
//
//   void goToNextStory() {
//     if (currentIndex.value < stories.length - 1) {
//       currentIndex.value++;
//       progress.value = 0.0;
//       startProgress();
//     } else {
//       Get.back();
//     }
//   }
//
//   Future<void> fetchMyStories() async {
//     try {
//       isLoading.value = true;
//       final token = await LocalStorage.getData(key: 'token');
//       final headers = {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       };
//       final response = await BaseClient.getRequest(
//         api: Api.myStory,
//         headers: headers,
//       );
//       final data = await BaseClient.handleResponse(response);
//       final myStoryModel = MyStoryModel.fromJson(data);
//       if (myStoryModel.success == true && myStoryModel.data != null) {
//         stories.value = myStoryModel.data!.data.where((story) => story.isDeleted != true).toList();
//       } else {
//         Get.snackbar('Error', myStoryModel.message ?? 'Failed to fetch stories');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch stories: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createStory({
//     required String mediaPath,
//     String? caption,
//   }) async {
//     try {
//       isLoading.value = true;
//       final token = await LocalStorage.getData(key: 'token');
//       var request = http.MultipartRequest('POST', Uri.parse(Api.createStory));
//       request.headers['Authorization'] = 'Bearer $token';
//       String? mimeType = lookupMimeType(mediaPath);
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'media',
//           mediaPath,
//           contentType: mimeType != null ? MediaType.parse(mimeType) : null,
//         ),
//       );
//       if (caption != null && caption.isNotEmpty) {
//         request.fields['caption'] = caption;
//       }
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//       await BaseClient.handleResponse(response);
//       await fetchMyStories(); // Refresh stories after creation
//       Get.snackbar('Success', 'Story created successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create story: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }