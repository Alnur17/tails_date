import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/others_pet_details_model.dart';

class OtherPetController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxBool isLoading = false.obs;

  Rx<OtherPetDetailsModel?> petDetails = Rx<OtherPetDetailsModel?>(null);

  //final StoryController storyController = Get.find();

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

  Future<void> addMorePets({
    required String image,
    String? info,
    String? name,
    int? gender,
    String? age,
    String? category,
    required BuildContext context,
  })
  async {
    try {
      isLoading.value = true;
      info = info?.trim() ?? "";
      //debugPrint('Attempt to create story with mediaPath: $image, info: "$info"');
      final token = await LocalStorage.getData(key: AppConstant.token);
      var request = http.MultipartRequest('POST', Uri.parse(Api.addNewPet));
      request.headers['Authorization'] = 'Bearer $token';
      String? mimeType = lookupMimeType(image);
      mimeType ??= 'application/octet-stream';
      debugPrint('Detected MIME type: $mimeType');
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image,
          contentType: MediaType.parse(mimeType),
        ),
      );
      request.fields['payload'] = jsonEncode({
        'name': name,
        'gender': gender,
        'age': age,
        'category': category,
        'info': info,
      });
      debugPrint('Payload fields: ${request.fields}');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint(
          'add more response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        await BaseClient.handleResponse(response);

        Get.snackbar(
            'Success', 'Others Pet Added successfully: "$info"');
        isLoading.value = false;
        Navigator.pop(context);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add pet: ${e.toString()}');
      debugPrint('Add more pet error: $e');
    } finally {
      isLoading.value = false;
      debugPrint('Add more pet completed, isLoading: ${isLoading.value}');
    }
  }


  Future<void> fetchPetDetails(String petId) async {
    try {
      isLoading.value = true;

      // Make API call using the BaseClient
      final response = await BaseClient.getRequest(
        api: Api.petDetails(petId),
        headers: {
          'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
        },
      );

      // Handle the response using the BaseClient's response handler
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        petDetails.value = OtherPetDetailsModel.fromJson(data); // Deserialize the response to the model
      } else {
        Get.snackbar('Error', 'Failed to load pet details');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load pet details: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
