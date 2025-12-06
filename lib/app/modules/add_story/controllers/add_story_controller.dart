import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/app/modules/home/controllers/story_controller.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';

import '../../../data/base_client.dart';

class AddStoryController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxBool isLoading = false.obs;

  final StoryController storyController = Get.find();

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  // Method to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  Future<void> createStory({
    required String mediaPath,
    String? caption,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      caption = caption?.trim() ?? "";
      debugPrint(
          'Attempt to create story with mediaPath: $mediaPath, caption: "$caption"');
      final token = await LocalStorage.getData(key: AppConstant.token);
      var request = http.MultipartRequest('POST', Uri.parse(Api.createStory));
      request.headers['Authorization'] = 'Bearer $token';
      String? mimeType = lookupMimeType(mediaPath);
      mimeType ??= 'application/octet-stream';
      debugPrint('Detected MIME type: $mimeType');
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          mediaPath,
          contentType: MediaType.parse(mimeType),
        ),
      );
      request.fields['payload'] =
          jsonEncode({'caption': caption});
      debugPrint('Payload fields: ${request.fields}');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint(
          'createStory response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        await BaseClient.handleResponse(response);

        debugPrint('Story created successfully, refreshing stories');
        await storyController.fetchStoryAuthors();

        Get.snackbar(
            'Success', 'Story created successfully with caption: "$caption"');
        isLoading.value = false;
        Navigator.pop(context);

      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create story: ${e.toString()}');
      debugPrint('createStory error: $e');
    } finally {
      isLoading.value = false;
      debugPrint('createStory completed, isLoading: ${isLoading.value}');
    }
  }
}
