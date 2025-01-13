import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostController extends GetxController {
  final selectedImages = <File>[].obs; // For storing selected images (posts)
  final selectedVideo = Rx<File?>(null); // For storing the selected video (reels)
  final postContentController = TextEditingController(); // For description input
  final isCreatingReel = false.obs; // Reactive variable to toggle between posts and reels

  @override
  void onClose() {
    // Dispose of the TextEditingController to avoid memory leaks
    postContentController.dispose();
    super.onClose();
  }

  // Toggle mode between posts and reels
  void toggleMode(bool isReelMode) {
    isCreatingReel.value = isReelMode;

    // Clear data when switching modes
    selectedImages.clear();
    selectedVideo.value = null;
    postContentController.clear();
  }

  // Pick images (for posts)
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

  // Pick a video (for reels)
  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedVideo = await picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedVideo != null) {
        selectedVideo.value = File(pickedVideo.path);
      } else {
        Get.snackbar('No Video Selected', 'Please select a video.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick video: $e');
    }
  }

  // Remove image by index (for posts)
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    } else {
      Get.snackbar('Error', 'Invalid index for removing image.');
    }
  }

  // Remove video (for reels)
  void removeVideo() {
    if (selectedVideo.value != null) {
      selectedVideo.value = null;
    } else {
      Get.snackbar('Error', 'No video to remove.');
    }
  }

  // Validate input before posting
  bool validateInput() {
    if (postContentController.text.isEmpty) {
      Get.snackbar('Error', 'Please write something before posting.');
      return false;
    }

    if (isCreatingReel.value && selectedVideo.value == null) {
      Get.snackbar('Error', 'Please select a video before posting.');
      return false;
    }

    if (!isCreatingReel.value && selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please select at least one image before posting.');
      return false;
    }

    return true;
  }

  // Post content
  void postContent() {
    if (!validateInput()) return;

    // Handle post submission logic
    if (isCreatingReel.value) {
      print('Reel submitted with description: ${postContentController.text}');
      print('Video path: ${selectedVideo.value!.path}');
    } else {
      print('Post submitted with description: ${postContentController.text}');
      print('Number of images: ${selectedImages.length}');
    }

    // Clear fields after posting
    postContentController.clear();
    selectedImages.clear();
    selectedVideo.value = null;
    Get.snackbar('Success', 'Your post has been uploaded!');
  }
}
