import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';

class SendRequestView extends GetView {
  final List<Map<String, String>> data;

  const SendRequestView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Send Request'),
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
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(item['image']!),
            ),
            title: Text(item['name']!),
            trailing: CustomButton(
              text: 'Cancel request',
              onPressed: () {},
              width: 140,
              height: 30,
              backgroundColor: AppColors.secondaryOrangeColor,
              textStyle: h3.copyWith(color: AppColors.white),
            ),
          );
        },
      ),
    );
  }
}
