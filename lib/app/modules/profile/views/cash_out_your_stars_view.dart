import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class CashOutYourStarsView extends GetView {
  const CashOutYourStarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('CashOut Your Stars'),
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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Turn your stars into cash. Each star equals \$0.01.',
                  style: h3),
              sh8,
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Star Balance',
                      style: h4.copyWith(
                          fontSize: 18, color: AppColors.brownColor),
                    ),
                    sh8,
                    Row(
                      children: [
                        Text('🌟'),
                        sw8,
                        Text(
                          '500 Stars Remaining',
                          style: h2,
                        ),
                      ],
                    ),
                    sh8,
                    Text(
                      'which equals \$5.00',
                      style: h4,
                    ),
                  ],
                ),
              ),
              sh16,
              Text('Cash Out Details', style: h2),
              sh8,
              Text('Enter cash out amount:', style: h4),
              sh8,
              CustomTextField(
                hintText: '\$0.00',
              ),
              sh8,
              Text(
                'Guidelines',
                style: h6,
              ),
              sh8,
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Text(
                    'Each star is worth \$0.01.',
                    style: h6,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Text(
                    'CashOuts are available on the 1st of each month.',
                    style: h6,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Text(
                    'The cashOut amount will be less than what you spent on points.',
                    style: h6,
                  ),
                ],
              ),
              sh24,
              CustomButton(
                text: 'Submit CashOut Request',
                onPressed: () {
                  showSubmitRequestDialog(context);
                },
              ),
              sh24,
              Text('CashOut Status', style: h2),
              sh8,
              Row(
                children: [
                  Text('Status:', style: h4),
                  sw8,
                  Text('No pending requests at the moment.', style: h4),
                ],
              ),
              sh16,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: CustomButton(
          text: 'WithDraw',
          onPressed: () {
            Get.snackbar(
              'Need Approval',
              'You need to submit CashOut request first.',
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
        ),
      ),
    );
  }

  Future showSubmitRequestDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "CashOut Request Submitted",
      titlePadding: EdgeInsets.only(top: 16),
      backgroundColor: AppColors.white,
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "You've requested to cash out \$5.00. Processing will occur on the 1st of the month.",
              style: h4.copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sh20,
          CustomButton(
            text: 'Close ',
            onPressed: () {},
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
