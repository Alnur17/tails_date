// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadPostController extends GetxController {
//   final selectedImages = <File>[].obs; // For storing selected images (posts)
//   final selectedVideo = Rx<File?>(null); // For storing the selected video (reels)
//   final isVideoInitialized = false.obs; // Tracks video initialization status
//   VideoPlayerController? videoPlayerController; // For video preview
//   final postContentController = TextEditingController(); // For description input
//   final isCreatingVideo = false.obs; // Reactive variable to toggle between posts and reels
//
//   @override
//   void onClose() {
//     postContentController.dispose();
//     videoPlayerController?.dispose();
//     super.onClose();
//   }
//
//   // Toggle mode between posts and reels
//   void toggleMode(bool isReelMode) {
//     isCreatingVideo.value = isReelMode;
//
//     // Clear data when switching modes
//     selectedImages.clear();
//     selectedVideo.value = null;
//     isVideoInitialized.value = false;
//     videoPlayerController?.dispose();
//     videoPlayerController = null;
//     postContentController.clear();
//   }
//
//   // Pick images (for posts)
//   Future<void> pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final List<XFile>? pickedFiles = await picker.pickMultiImage();
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
//       } else {
//         Get.snackbar('No Images Selected', 'Please select at least one image.');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick images: $e');
//     }
//   }
//
//   // Pick a video (for reels)
//   Future<void> pickVideo() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? pickedVideo = await picker.pickVideo(
//         source: ImageSource.gallery,
//       );
//       if (pickedVideo != null) {
//         selectedVideo.value = File(pickedVideo.path);
//         isVideoInitialized.value = false;
//
//         // Dispose the previous controller
//         videoPlayerController?.dispose();
//
//         // Initialize the video player controller
//         videoPlayerController = VideoPlayerController.file(File(pickedVideo.path))
//           ..initialize().then((_) {
//             videoPlayerController!.pause(); // Pause to display the first frame
//             isVideoInitialized.value = true; // Notify that the video is ready
//           }).catchError((e) {
//             Get.snackbar('Error', 'Failed to initialize video: $e');
//           });
//       } else {
//         Get.snackbar('No Video Selected', 'Please select a video.');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick video: $e');
//     }
//   }
//
//   // Remove image by index (for posts)
//   void removeImage(int index) {
//     if (index >= 0 && index < selectedImages.length) {
//       selectedImages.removeAt(index);
//     } else {
//       Get.snackbar('Error', 'Invalid index for removing image.');
//     }
//   }
//
//   // Remove video (for reels)
//   void removeVideo() {
//     selectedVideo.value = null;
//     isVideoInitialized.value = false;
//     videoPlayerController?.dispose();
//     videoPlayerController = null;
//   }
//
//   // Validate input before posting
//   bool validateInput() {
//     if (postContentController.text.isEmpty) {
//       Get.snackbar('Error', 'Please write something before posting.');
//       return false;
//     }
//
//     if (isCreatingVideo.value && selectedVideo.value == null) {
//       Get.snackbar('Error', 'Please select a video before posting.');
//       return false;
//     }
//
//     if (!isCreatingVideo.value && selectedImages.isEmpty) {
//       Get.snackbar('Error', 'Please select at least one image before posting.');
//       return false;
//     }
//
//     return true;
//   }
//
//   // Post content
//   void postContent() {
//     if (!validateInput()) return;
//
//     // Handle post submission logic
//     if (isCreatingVideo.value) {
//       print('Reel submitted with description: ${postContentController.text}');
//       print('Video path: ${selectedVideo.value!.path}');
//     } else {
//       print('Post submitted with description: ${postContentController.text}');
//       print('Number of images: ${selectedImages.length}');
//     }
//
//     // Clear fields after posting
//     postContentController.clear();
//     selectedImages.clear();
//     selectedVideo.value = null;
//     isVideoInitialized.value = false;
//     videoPlayerController?.dispose();
//     videoPlayerController = null;
//     Get.snackbar('Success', 'Your post has been uploaded!');
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/app/data/base_client.dart';
import 'package:tails_date/common/helper/local_store.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';

class UploadPostController extends GetxController {
  final selectedImages = <File>[].obs;
  final selectedVideo = Rx<File?>(null);
  final isVideoInitialized = false.obs;
  VideoPlayerController? videoPlayerController;
  final postContentController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  final isCreatingVideo = false.obs;
  final selectedCategoryId = RxString('');
  final isLoading = false.obs; // New loading state

  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    if (homeController.categories.isEmpty) {
      homeController.getCategories();
    }
  }

  @override
  void onClose() {
    postContentController.dispose();
    locationController.dispose();
    categoryController.dispose();
    videoPlayerController?.dispose();
    super.onClose();
  }

  void toggleMode(bool isReelMode) {
    isCreatingVideo.value = isReelMode;
    selectedImages.clear();
    selectedVideo.value = null;
    isVideoInitialized.value = false;
    videoPlayerController?.dispose();
    videoPlayerController = null;
    postContentController.clear();
    locationController.clear();
    categoryController.clear();
    selectedCategoryId.value = '';
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      } else {
        Get.snackbar('No Images Selected', 'Please select at least one image.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images: $e');
    }
  }

  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        selectedVideo.value = File(pickedVideo.path);
        isVideoInitialized.value = false;
        videoPlayerController?.dispose();
        videoPlayerController = VideoPlayerController.file(File(pickedVideo.path))
          ..initialize().then((_) {
            videoPlayerController!.pause();
            isVideoInitialized.value = true;
          }).catchError((e) {
            Get.snackbar('Error', 'Failed to initialize video: $e');
          });
      } else {
        Get.snackbar('No Video Selected', 'Please select a video.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick video: $e');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    } else {
      Get.snackbar('Error', 'Invalid index for removing image.');
    }
  }

  void removeVideo() {
    selectedVideo.value = null;
    isVideoInitialized.value = false;
    videoPlayerController?.dispose();
    videoPlayerController = null;
  }

  bool validateInput() {
    if (postContentController.text.isEmpty) {
      Get.snackbar('Error', 'Please write something before posting.');
      return false;
    }
    if (isCreatingVideo.value && selectedVideo.value == null) {
      Get.snackbar('Error', 'Please select a video before posting.');
      return false;
    }
    if (!isCreatingVideo.value && selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please select at least one image before posting.');
      return false;
    }
    if (!isCreatingVideo.value && locationController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a location.');
      return false;
    }
    if (!isCreatingVideo.value && selectedCategoryId.value.isEmpty) {
      Get.snackbar('Error', 'Please select a category.');
      return false;
    }
    return true;
  }

  Future<void> postContent() async {
    if (!validateInput()) return;

    isLoading.value = true;

    var token = LocalStorage.getData(key: AppConstant.token);

    try {
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };

      if (isCreatingVideo.value) {
        var request = http.MultipartRequest('POST', Uri.parse(Api.createReels));
        request.fields['payload'] = jsonEncode({'caption': postContentController.text});
        request.files.add(await http.MultipartFile.fromPath('video', selectedVideo.value!.path));
        request.headers.addAll(headers);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        var data = await BaseClient.handleResponse(response);

        if (data != null) {
          Get.snackbar('Success', 'Reel uploaded successfully!');
        }
      } else {
        var request = http.MultipartRequest('POST', Uri.parse(Api.createPost));
        request.fields['payload'] = jsonEncode({
          'caption': postContentController.text,
          'location': locationController.text,
          'category': selectedCategoryId.value,
        });
        for (var image in selectedImages) {
          request.files.add(await http.MultipartFile.fromPath('images', image.path));
        }
        request.headers.addAll(headers);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        var data = await BaseClient.handleResponse(response);

        if (data != null) {
          Get.snackbar('Success', 'Post uploaded successfully!');
        }
      }

      postContentController.clear();
      locationController.clear();
      categoryController.clear();
      selectedImages.clear();
      selectedVideo.value = null;
      isVideoInitialized.value = false;
      videoPlayerController?.dispose();
      videoPlayerController = null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload: $e');
    } finally {
      isLoading.value = false;
    }
  }
}