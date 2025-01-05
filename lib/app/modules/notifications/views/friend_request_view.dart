import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_list_tile.dart';

class FriendRequestView extends GetView {
  final List<Map<String, String>> data;

  const FriendRequestView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Friend Request'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return CustomListTile(
            name: item['name']!,
            image: item['image']!,
            actionText: 'Confirm',
            showCloseButton: true,
            actionOnPressed: () {},
            actionStyle: CustomButton(
              width: 100,
              height: 30,
              text: 'Confirm',
              onPressed: () {},
              borderColor: AppColors.black,
              backgroundColor: AppColors.white,
              textStyle: h3.copyWith(color: AppColors.black),
            ),
          );
        },
      ),
    );
  }
}
