import 'dart:convert';

import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snack_bar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/my_collections_model.dart';

class CollectionsController extends GetxController {
  final collections = <Datum>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollections();
  }

  Future<void> fetchCollections() async {
    try {
      isLoading.value = true;
      final token = LocalStorage.getData(key: 'token') ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await BaseClient.getRequest(
        api: Api.collections,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      final collectionsData = MyCollectionsModel.fromJson(result);
      if (collectionsData.success == true) {
        collections.assignAll(collectionsData.data);
      } else {
        kSnackBar(
          message: collectionsData.message ?? 'Failed to load collections',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrRemoveCollection(String postId) async {
    try {
      final token = LocalStorage.getData(key: 'token') ?? '';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({'post': postId});

      final response = await BaseClient.postRequest(
        api: Api.addOrRemoveCollections,
        body: body,
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);
      if (result['success'] == true) {
        kSnackBar(
          message: result['message']?.toString() ?? 'Collection updated successfully',
          bgColor: AppColors.green,
        );
        await fetchCollections();
      } else {
        kSnackBar(
          message: result['message']?.toString() ?? 'Failed to update collection',
          bgColor: AppColors.red,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.red,
      );
    }
  }

}