// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
//
// import '../../../data/dummy_data.dart';
//
// class MySearchController extends GetxController {
//
//   final searchController = TextEditingController();
//   final posts = DummyData.posts.obs;
//   //final posts = DummyData.posts.obs;
//   final filteredPosts = <Map<String, dynamic>>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     filteredPosts.assignAll(posts);
//     searchController.addListener(() {
//       filterPosts(searchController.text);
//     });
//   }
//
//   void filterPosts(String query) {
//     if (query.isEmpty) {
//       filteredPosts.assignAll(posts);
//     } else {
//       filteredPosts.assignAll(posts.where((post) {
//         final name = post['userName']?.toLowerCase() ?? '';
//         final location = post['location']?.toLowerCase() ?? '';
//         final lowerCaseQuery = query.toLowerCase();
//         return name.contains(lowerCaseQuery) || location.contains(lowerCaseQuery);
//       }).toList());
//     }
//   }
//
//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';

import '../model/all_post_model.dart';

class MySearchController extends GetxController {
  final searchController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();
  final filteredPosts = <AllPostData>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredPosts.assignAll(homeController.posts);
    homeController.posts.listen((_) {
      filterPosts(searchController.text);
    });
    searchController.addListener(() {
      filterPosts(searchController.text);
    });
  }

  void filterPosts(String query) {
    if (query.isEmpty) {
      filteredPosts.assignAll(homeController.posts);
    } else {
      filteredPosts.assignAll(homeController.posts.where((post) {
        final name = post.author?.name?.toLowerCase() ?? '';
        final location = post.location?.toLowerCase() ?? '';
        final lowerCaseQuery = query.toLowerCase();
        return name.contains(lowerCaseQuery) || location.contains(lowerCaseQuery);
      }).toList());
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}