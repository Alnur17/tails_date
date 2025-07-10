import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../login/views/login_view.dart';
import '../model/my_profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Rx<MyProfileModel?>(null); // Store profile data

  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isPasswordVisible2 = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void togglePasswordVisibility2() {
    isPasswordVisible2.toggle();
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Api.myProfile, headers: headers),
      );

      if (responseBody != null) {
        profileData.value = MyProfileModel.fromJson(responseBody);
        kSnackBar(
            message:
                profileData.value!.message ?? "Profile fetched successfully",
            bgColor: AppColors.green);
      } else {
        throw 'Failed to fetch profile!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error fetching profile: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }

  /// Change password
  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      var map = {"oldPassword": currentPassword, "newPassword": newPassword};
      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      debugPrint(";;;;;;;;;;;;$headers;;;;;;;;;");

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.changePassword, body: jsonEncode(map), headers: headers),
      );

      debugPrint(";;;;;;;;;;;;$responseBody;;;;;;;;;");

      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        Get.offAll(() => LoginView());
        isLoading(false);
      } else {
        throw 'Reset password failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error changing password: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }

  /// Upload image to owner gallery
  Future<void> uploadOwnerGalleryImage() async {
    try {
      isLoading(true);
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        kSnackBar(message: "No image selected", bgColor: AppColors.orange);
        return;
      }

      final mimeType = lookupMimeType(image.path);
      if (!['image/jpeg', 'image/png'].contains(mimeType)) {
        kSnackBar(
            message: "Only JPEG and PNG images are supported",
            bgColor: AppColors.orange);
        return;
      }
      if (!['.jpg', '.jpeg', '.png']
          .contains(p.extension(image.path).toLowerCase())) {
        kSnackBar(
            message: "Only JPG and PNG images are supported",
            bgColor: AppColors.orange);
        return;
      }

      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Authorization': 'Bearer $token',
      };
      debugPrint(";;;;;;;;;;;;;;;; This is headers $headers ;;;;;;;;;;;;;;;;");

      var request =
          http.MultipartRequest('POST', Uri.parse(Api.profileOwnerGallery));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType:
            MediaType.parse(mimeType!), //MediaType from http_parser package
      ));

      var streamedResponse = await request.send();
      debugPrint('Streamed Response Status: ${streamedResponse.statusCode}');
      var response = await http.Response.fromStream(streamedResponse);
      debugPrint('Raw Response Status: ${response.statusCode}');
      debugPrint('Raw Response Body: ${response.body}');

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null) {
        kSnackBar(
            message:
                responseBody["message"] ?? "Image uploaded to owner gallery",
            bgColor: AppColors.green);
        await fetchProfile(); // Refresh profile data
      } else {
        throw 'Failed to upload image!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error uploading image: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }

  /// Upload image to pet gallery
  Future<void> uploadPetGalleryImage() async {
    try {
      isLoading(true);
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        kSnackBar(message: "No image selected", bgColor: AppColors.orange);
        return;
      }

      final mimeType = lookupMimeType(image.path);
      if (!['image/jpeg', 'image/png'].contains(mimeType)) {
        kSnackBar(
            message: "Only JPEG and PNG images are supported",
            bgColor: AppColors.orange);
        return;
      }
      if (!['.jpg', '.jpeg', '.png']
          .contains(p.extension(image.path).toLowerCase())) {
        kSnackBar(
            message: "Only JPG and PNG images are supported",
            bgColor: AppColors.orange);
        return;
      }

      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request =
          http.MultipartRequest('POST', Uri.parse(Api.profilePetGallery));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType.parse(mimeType!), //from http_parser package
      ));

      var streamedResponse = await request.send();
      debugPrint('Streamed Response Status: ${streamedResponse.statusCode}');
      var response = await http.Response.fromStream(streamedResponse);
      debugPrint('Raw Response Status: ${response.statusCode}');
      debugPrint('Raw Response Body: ${response.body}');

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null) {
        kSnackBar(
            message: responseBody["message"] ?? "Image uploaded to pet gallery",
            bgColor: AppColors.green);
        await fetchProfile(); // Refresh profile data
      } else {
        throw 'Failed to upload image!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error uploading image: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }

  Future<void> patchRemoveOwnerGalleryImage(String imagePath) async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };
      var body = jsonEncode({"image": imagePath});

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
          api: Api.removeProfileOwnerGallery,
          body: body,
          headers: headers,
        ),
      );

      if (responseBody != null) {
        kSnackBar(
            message:
                responseBody["message"] ?? "Image removed from owner gallery",
            bgColor: AppColors.green);
        await fetchProfile(); // Refresh profile data
      } else {
        throw 'Failed to remove image!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error removing image: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }

  Future<void> patchRemovePetGalleryImage(String imagePath) async {
    try {
      isLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      var body = jsonEncode({"image": imagePath});

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
          api: Api.removeProfilePetGallery,
          body: body,
          headers: headers,
        ),
      );

      if (responseBody != null) {
        kSnackBar(
            message:
                responseBody["message"] ?? "Image removed from pet gallery",
            bgColor: AppColors.green);
        await fetchProfile();
      } else {
        throw 'Failed to remove image!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error removing image: $e", bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }
}
