import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import 'package:tails_date/app/modules/profile/model/my_reels_model.dart';
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
  var profileData = Rx<MyProfileModel?>(null);
  var otherProfileData = Rx<MyProfileModel?>(null);
  var myReelsData = <MyReelsData>[].obs;
  var otherReelsData = <MyReelsData>[].obs;
  var isProfileLoading = false.obs;
  var isOtherProfileLoading = false.obs;
  var isReelsLoading = false.obs;

  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isPasswordVisible2 = false.obs;

  final ImagePicker _picker = ImagePicker();

  var selectedImage = Rx<XFile?>(null);
  var ownerImage = Rx<XFile?>(null);
  var coverImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchMyReels();
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

  Future<void> fetchProfile() async {
    try {
      isProfileLoading(true);
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
        final String userId =   profileData.value?.data?.id ?? '';
       // final String userId =   responseBody['data']['_id'].toString();
        LocalStorage.saveData(key:  AppConstant.userId, data: userId);
        print("User Id : ${LocalStorage.getData(key: AppConstant.userId)}");
        // kSnackBar(
        //   message: profileData.value!.message ?? "Profile fetched successfully",
        //   bgColor: AppColors.green,
        // );
      } else {
        throw 'Failed to fetch profile!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error fetching profile: $e", bgColor: AppColors.red);
    } finally {
      isProfileLoading(false);
    }
  }

  Future<void> fetchOtherProfile(String userId) async {
    try {
      isOtherProfileLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.token)}',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: Api.othersProfile(userId), // Adjust the endpoint as per your API
          headers: headers,
        ),
      );

      if (responseBody != null) {
        otherProfileData.value = MyProfileModel.fromJson(responseBody);
        kSnackBar(
          message: "User profile fetched successfully",
          bgColor: AppColors.green,
        );
      } else {
        throw 'Failed to fetch user profile!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      kSnackBar(message: "Error fetching user profile: $e", bgColor: AppColors.red);
    } finally {
      isOtherProfileLoading(false);
    }
  }

  Future<void> fetchMyReels() async {
    try {
      isReelsLoading(true);
      var token = LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.myReels,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final result = await BaseClient.handleResponse(response);
      final myReelsModel = MyReelsModel.fromJson(result);
      if (myReelsModel.success == true) {
        myReelsData.assignAll(myReelsModel.data);
      } else {
        kSnackBar(
          message: myReelsModel.message ?? 'Failed to load reels',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isReelsLoading(false);
    }
  }

  Future<void> fetchOtherReelsByUserId(String userId) async {
    try {
      isReelsLoading(true);
      var token = LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.otherReels(userId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final result = await BaseClient.handleResponse(response);
      final othersReelsModel = MyReelsModel.fromJson(result);
      if (othersReelsModel.success == true) {
        otherReelsData.assignAll(othersReelsModel.data);
      } else {
        kSnackBar(
          message: othersReelsModel.message ?? 'Failed to load reels',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isReelsLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await BaseClient.deleteRequest(
        api: Api.deleteUser,
        headers: headers,
      );

      var result = await BaseClient.handleResponse(response);

      kSnackBar(
        message: 'Account deleted successfully',
        bgColor: AppColors.green,
      );
      BaseClient.logout();
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    }
  }

  Future<void> changePassword({
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

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.changePassword,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        Get.offAll(() => LoginView());
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
          bgColor: AppColors.orange,
        );
        return;
      }
      if (!['.jpg', '.jpeg', '.png']
          .contains(p.extension(image.path).toLowerCase())) {
        kSnackBar(
          message: "Only JPG and PNG images are supported",
          bgColor: AppColors.orange,
        );
        return;
      }

      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request =
          http.MultipartRequest('POST', Uri.parse(Api.profileOwnerGallery));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType.parse(mimeType!),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null) {
        kSnackBar(
          message: responseBody["message"] ?? "Image uploaded to owner gallery",
          bgColor: AppColors.green,
        );
        await fetchProfile();
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
          bgColor: AppColors.orange,
        );
        return;
      }
      if (!['.jpg', '.jpeg', '.png']
          .contains(p.extension(image.path).toLowerCase())) {
        kSnackBar(
          message: "Only JPG and PNG images are supported",
          bgColor: AppColors.orange,
        );
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
        contentType: MediaType.parse(mimeType!),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null) {
        kSnackBar(
          message: responseBody["message"] ?? "Image uploaded to pet gallery",
          bgColor: AppColors.green,
        );
        await fetchProfile();
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
          bgColor: AppColors.green,
        );
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
          message: responseBody["message"] ?? "Image removed from pet gallery",
          bgColor: AppColors.green,
        );
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

  Future<void> updateProfile({
    required String name,
    required String location,
    required int age,
    required String gender,
    required String category,
    required String petInfo,
    required String ownerName,
    required String ownerRelationshipStatus,
    required String ownerGender,
    XFile? selectedImage,
    XFile? ownerImage,
    XFile? coverImage,
  }) async {
    try {
      isLoading(true);
      String token = LocalStorage.getData(key: AppConstant.token);
      if (token.isEmpty) {
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Api.editProfile));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      Map<String, dynamic> payload = {
        "name": name,
        "gender": gender.toLowerCase(),
        "location": location,
        "age": age,
        "category": category,
        "pet_info": petInfo,
        "owner_name": ownerName,
        "owner_relationship_status": ownerRelationshipStatus.toLowerCase(),
        "owner_gender": ownerGender.toLowerCase(),
      };

      request.fields['payload'] = jsonEncode(payload);

      if (selectedImage != null) {
        String imagePath = selectedImage.path;
        String? mimeType = lookupMimeType(imagePath);
        if (mimeType != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: MediaType.parse(mimeType),
          ));
        } else {
          kSnackBar(
              message: "Unsupported image type", bgColor: AppColors.orange);
        }
      }

      if (ownerImage != null) {
        String imagePath = ownerImage.path;
        String? mimeType = lookupMimeType(imagePath);
        if (mimeType != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'owner_image',
            imagePath,
            contentType: MediaType.parse(mimeType),
          ));
        } else {
          kSnackBar(
              message: "Unsupported image type", bgColor: AppColors.orange);
        }
      }

      if (coverImage != null) {
        String imagePath = coverImage.path;
        String? mimeType = lookupMimeType(imagePath);
        if (mimeType != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cover_image',
          imagePath,
          contentType: MediaType.parse(mimeType),
        ));
        } else {
          kSnackBar(message: "Unsupported image type", bgColor: AppColors.orange);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        kSnackBar(
          message: "Invalid server response format",
          bgColor: AppColors.orange,
        );
        debugPrint("JSON Decode Error: $e");
        return;
      }

      if (response.statusCode == 200) {
        kSnackBar(
          message: responseBody["message"] ?? "Profile updated successfully",
          bgColor: AppColors.green,
        );
        this.selectedImage.value = null;
        this.ownerImage.value = null;
        this.coverImage.value = null;
        await fetchProfile();
        if (Get.context != null && Navigator.of(Get.context!).canPop()) {
          Navigator.pop(Get.context!);
        }
      } else {
        kSnackBar(
          message: responseBody["message"] ?? "Failed to update profile",
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: "Error updating profile: $e",
        bgColor: AppColors.red,
      );
      debugPrint("Update Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
