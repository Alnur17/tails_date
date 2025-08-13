import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';

class AddStoryController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxBool isLoading = false.obs;

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

  Future<void> uploadStory() async {
    if (selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image first.');
      return;
    }

    isLoading.value = true;

    try {
      var uri = Uri.parse("http://172.252.13.83:5004/api/v1/stories");

      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
        'Accept': 'application/json',
      });

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // key expected by API
          selectedImagePath.value,
        ),
      );

      // Optional: Add other form fields
      request.fields['description'] = 'This is my story!';

      // Send request
      var response = await request.send();

      // Read response body
      final respStr = await response.stream.bytesToString();
      print('Response Status: ${response.statusCode}');
      print('Response Body: $respStr');

      if (response.statusCode == 200) {
        print('Story uploaded successfully!');
        Get.snackbar('Success', 'Story uploaded successfully!');
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to upload story. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

}
