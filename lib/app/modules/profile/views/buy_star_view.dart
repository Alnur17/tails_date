import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class BuyStarView extends GetView {
  const BuyStarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Buy Stars'),
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
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black),
          color: AppColors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppImages.starCard,
                scale: 4,
              ),
              sh12,
              Text(
                '🌟 Add Star to your balance to send gifts 🌟',
                style: h4,
              ),
              sh16,
              StarContainer(
                numberOfStars: '99',
                price: 0.99,
                backgroundColor: AppColors.mainColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your first stars are discounted for a limited time!',
                  style: h6,
                ),
              ),
              sh16,
              StarContainer(
                numberOfStars: '75',
                price: 0.99,
              ),
              sh16,
              StarContainer(
                numberOfStars: '235',
                price: 2.99,
              ),
              sh16,
              StarContainer(
                numberOfStars: '490',
                price: 5.99,
              ),
              sh16,
              StarContainer(
                numberOfStars: '830',
                price: 9.99,
              ),
              sh16,
              StarContainer(
                numberOfStars: '1000',
                price: 12.99,
              ),
              sh30,
              CustomButton(
                text: 'Buy Stars',
                onPressed: () {},
                backgroundColor: AppColors.mainColor,
                textStyle: h3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StarContainer extends StatelessWidget {
  final String numberOfStars;
  final double price;
  final Color? backgroundColor;

  const StarContainer({
    super.key,
    required this.numberOfStars,
    required this.price,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryOrangeColor),
        color: backgroundColor ?? AppColors.transparent,
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.starFilled,
            scale: 4,
          ),
          sw8,
          Text('$numberOfStars Stars'),
          Spacer(),
          Text('\$$price'),
        ],
      ),
    );
  }
}
