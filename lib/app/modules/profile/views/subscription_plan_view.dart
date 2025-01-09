import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/widgets/subscription_plan_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';

class SubscriptionPlanView extends StatefulWidget {
  const SubscriptionPlanView({super.key});

  @override
  State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
}

class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
  String? currentPlan; // Track the current subscription plan

  // Helper function to determine the button text
  String _getButtonText(String plan) {
    if (currentPlan == null) return 'Subscribe Now';
    if (plan == currentPlan) return 'Renew Plan';
    return 'Upgrade to ${plan.split(' ')[0]}';
  }

  // Helper function to determine if the button should be shown
  bool _shouldShowButton(String plan) {
    const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
    if (currentPlan == null)
      return true; // Show all plans for unsubscribed users
    final currentIndex = planOrder.indexOf(currentPlan!);
    final planIndex = planOrder.indexOf(plan);
    return planIndex >= currentIndex; // Show only the current or higher plans
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Subscription Plan'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentPlan != null) ...[
                // My Current Plan Section
                Text(
                  'My Current Plan',
                  style: h2.copyWith(fontSize: 20),
                ),
                sh12,
                SubscriptionPlanCard(
                  title: currentPlan!,
                  duration: currentPlan == 'Silver Plan'
                      ? '1 Month'
                      : currentPlan == 'Gold Plan'
                          ? '3 Months'
                          : '1 Year',
                  price: currentPlan == 'Silver Plan'
                      ? '\$9.99'
                      : currentPlan == 'Gold Plan'
                          ? '\$24.99'
                          : '\$99.99',
                  description: 'Enjoy your current subscription benefits.',
                  expiryDate: '31 Dec 2024',
                  remainingDays: 23,
                  onSubscribe: () {
                    Get.snackbar(
                      'Renewed',
                      'Your $currentPlan has been renewed!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  isCurrentPlan: true,
                  buttonText: _getButtonText(currentPlan!),
                ),
                sh30,
                // Upgrade Plan Section
                Text(
                  'Upgrade Plan',
                  style: h2.copyWith(fontSize: 20),
                ),
              ],
              if (_shouldShowButton('Silver Plan'))
                SubscriptionPlanCard(
                  title: 'Silver Plan',
                  duration: '1 Month',
                  price: '\$9.99',
                  description:
                      'Perfect for trying out our features at a low commitment.',
                  onSubscribe: () {
                    setState(() {
                      currentPlan = 'Silver Plan';
                    });
                    Get.snackbar(
                      'Success',
                      'You have subscribed to the Silver Plan!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  isCurrentPlan: currentPlan == 'Silver Plan',
                  buttonText: _getButtonText('Silver Plan'),
                ),
              sh20,
              if (_shouldShowButton('Gold Plan'))
                SubscriptionPlanCard(
                  title: 'Gold Plan',
                  duration: '3 Months',
                  price: '\$24.99',
                  description:
                      'Our most popular plan for those who love value and flexibility!',
                  onSubscribe: () {
                    setState(() {
                      currentPlan = 'Gold Plan';
                    });
                    Get.snackbar(
                      'Success',
                      'You have upgraded to the Gold Plan!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  titleTextColor: AppColors.green,
                  buttonColor: AppColors.green,
                  buttonTextColor: AppColors.white,
                  isCurrentPlan: currentPlan == 'Gold Plan',
                  buttonText: _getButtonText('Gold Plan'),
                ),
              sh20,
              if (_shouldShowButton('Platinum Plan'))
                SubscriptionPlanCard(
                  title: 'Platinum Plan',
                  duration: '1 Year',
                  price: '\$99.99',
                  description:
                      'Go all-in for maximum savings and exclusive perks!',
                  onSubscribe: () {
                    setState(() {
                      currentPlan = 'Platinum Plan';
                    });
                    Get.snackbar(
                      'Success',
                      'You have upgraded to the Platinum Plan!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  isCurrentPlan: currentPlan == 'Platinum Plan',
                  buttonText: _getButtonText('Platinum Plan'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
