import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostController extends GetxController {
  final selectedImages = <File>[].obs;
  final postContentController = TextEditingController();

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void postContent() {
    if (postContentController.text.isEmpty || selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please add content and images before posting.');
      return;
    }

    // Handle post submission logic
    print('Post submitted with content: ${postContentController.text}');
    print('Images: ${selectedImages.length}');

    // Clear fields after posting
    postContentController.clear();
    selectedImages.clear();
    Get.snackbar('Success', 'Your post has been uploaded!');
  }
}
