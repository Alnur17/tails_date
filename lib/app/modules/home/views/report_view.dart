import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_checkbox_row.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class ReportView extends GetView {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Report',
          style: h2,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why are you reporting this post?',
              style: h3,
            ),
            sh20,
            CustomCheckboxRow(
              value: false,
              text: 'Bullying, harassment or abuse',
              onChanged: (value) {},
            ),
            sh16,
            CustomCheckboxRow(
              value: false,
              text: 'Violent, hateful or disturbing content',
              onChanged: (value) {},
            ),
            sh16,
            CustomCheckboxRow(
              value: false,
              text: 'Block this user',
              onChanged: (value) {},
            ),
            sh16,
            CustomCheckboxRow(
              value: false,
              text: 'Others Reason',
              onChanged: (value) {},
            ),
            sh30,
            CustomTextField(
              height: 250,
              hintText: 'Write Something here......',
            ),
            sh24,
            CustomButton(text: 'Submit', onPressed: () {
              _showThankYouPopup(context);
            }),
          ],
        ),
      ),
    );
  }

  void _showThankYouPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thank you for your report!',
                  style: h3.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                sh8,
                Text(
                  'The content has been flagged for review. Admin will look into it and take appropriate action.',
                  style: h5.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                sh16,
                CustomButton(
                  text: 'Close',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
