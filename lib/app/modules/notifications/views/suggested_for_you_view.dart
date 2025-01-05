import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';

class SuggestedForYouView extends GetView {
  final List<Map<String, String>> data;
  const SuggestedForYouView( {super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Suggested For You'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back,scale: 4,),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              preIcon: Image.asset(
                AppImages.searchTwo,
                scale: 4,
              ),
              hintText: 'Search Friends',
            ),
          ),
          sh12,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item['image']!),
                  ),
                  title: Text(item['name']!),
                  trailing: CustomButton(
                    text: 'Add friend',
                    onPressed: () {},
                    width: 120,
                    height: 30,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
