import 'package:flutter/material.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/widgets/custom_button.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final String title;
  final String duration;
  final String price;
  final String description;
  final VoidCallback onSubscribe;
  final Color? containerColor;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final Color? titleTextColor;
  final String? expiryDate;
  final int? remainingDays;
  final bool isCurrentPlan;
  final String buttonText; // New parameter for button text

  const SubscriptionPlanCard({
    super.key,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.onSubscribe,
    required this.buttonText, // Make buttonText required
    this.containerColor,
    this.buttonColor,
    this.buttonTextColor,
    this.borderColor,
    this.titleTextColor,
    this.expiryDate,
    this.remainingDays,
    this.isCurrentPlan = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? AppColors.black),
        color: containerColor ?? AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: h2.copyWith(
              fontSize: 20,
              color: titleTextColor ?? AppColors.brownColor,
            ),
          ),
          sh8,
          Row(
            children: [
              Text('$duration - ', style: h2),
              Text(
                price,
                style: h1.copyWith(color: AppColors.black),
              ),
            ],
          ),
          if (isCurrentPlan && expiryDate != null && remainingDays != null) ...[
            sh8,
            Text(
              'Expiry Date: $expiryDate',
              style: h3,
            ),
            sh8,
            Text(
              'Remaining Days: $remainingDays Days',
              style: h3.copyWith(color: Colors.red),
            ),
          ],
          sh8,
          Text(
            description,
            style: h3,
          ),
          sh8,
          CustomButton(
            text: buttonText,
            onPressed: onSubscribe,
            backgroundColor: buttonColor ?? AppColors.mainColor,
            textStyle: h3.copyWith(color: buttonTextColor ?? AppColors.black),
          ),
        ],
      ),
    );
  }
}