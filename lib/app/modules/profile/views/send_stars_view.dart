import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/controllers/send_stars_controller.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';

class SendStarsView extends GetView<SendStarsController> {
  const SendStarsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SendStarsController sendStarsController = Get.put(SendStarsController());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Send Stars'),
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
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black),
          gradient: LinearGradient(
            colors: AppColors.gradientColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Enjoyed this post?',
                style: h3,
              ),
              sh24,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.black,
                  ),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.starCardTwo,
                      scale: 4,
                    ),
                    sw12,
                    Expanded(
                      child: Text(
                        'Show your appreciation by sending a star to the creator and let them know you loved it!',
                        style: h6.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              sh24,
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TappableContainer(
                      iconPath: AppImages.starFilled,
                      text: '50',
                      isSelected: sendStarsController.selectedAmount.value == 50,
                      onTap: () {
                        sendStarsController.selectAmount(50);
                      },
                    ),
                    TappableContainer(
                      iconPath: AppImages.starFilled,
                      text: '100',
                      isSelected: sendStarsController.selectedAmount.value == 100,
                      onTap: () {
                        sendStarsController.selectAmount(100);
                      },
                    ),
                    TappableContainer(
                      iconPath: AppImages.starFilled,
                      text: '200',
                      isSelected: sendStarsController.selectedAmount.value == 200,
                      onTap: () {
                        sendStarsController.selectAmount(200);
                      },
                    ),
                  ],
                );
              }),
              sh8,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Custom Amount',
                  style: h3.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              sh8,
              CustomTextField(
                hintText: 'Send Stars',
                preIcon: Image.asset(
                  AppImages.starFilled,
                  scale: 4,
                ),
                controller: sendStarsController.customAmountController,
              ),
              sh24,
              CustomButton(
                text: 'Send Stars 🌟',
                onPressed: () {
                  final enteredAmount = sendStarsController.getSelectedAmount();
                  log('Sending $enteredAmount stars!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TappableContainer extends StatelessWidget {
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final String iconPath;
  final String text;
  final bool isSelected;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  const TappableContainer({
    super.key,
    this.width,
    this.borderRadius,
    this.borderColor,
    required this.iconPath,
    required this.text,
    required this.isSelected,
    this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          border: Border.all(
            color: borderColor ?? AppColors.black,
          ),
          color: isSelected ? AppColors.mainColor : AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              scale: 4,
            ),
            sw8,
            Text(
              text,
              style: textStyle ?? h3,
            ),
          ],
        ),
      ),
    );
  }
}