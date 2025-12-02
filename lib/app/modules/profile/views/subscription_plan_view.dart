import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/widgets/subscription_plan_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import '../controllers/subscription_plan_controller.dart';

class SubscriptionPlanView extends StatelessWidget {
  const SubscriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionPlanController controller =
        Get.put(SubscriptionPlanController());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Subscription_Plans'.tr),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.black,));
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: h3));
        }
        if (controller.subscriptionPlans.isEmpty) {
          return Center(
              child: Text('No_Subscription_Plans_Available'.tr, style: h3));
        }

        final currentSubscription = controller.myCurrentSubscription.value;
        final currentPlan = currentSubscription?.data?.plan?.name;
        final currentPlanDetails = currentSubscription?.data?.plan;
        final endDate = currentSubscription?.data?.endDate;
        final trial = currentSubscription?.data?.isTrial;
        final parsedEndDate =
            endDate != null ? DateTime.tryParse(endDate) : null;

        final remainingDays = parsedEndDate?.difference(DateTime.now()).inDays;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (remainingDays != null &&
                    remainingDays > 0 &&
                    (trial == true || currentPlanDetails != null)) ...[
                  Text(
                    'My_Current_Plan'.tr,
                    style: h2.copyWith(fontSize: 20, color: AppColors.black),
                  ),
                  sh12,
                  trial == true
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Free Trial',
                                style: h2.copyWith(fontSize: 20,color: AppColors.brownColor),
                              ),
                              sh8,
                              Text(
                                'Expiry Date: ${_formatDate(endDate)}',
                                style: h3,
                              ),
                              sh8,
                              Text(
                                'Remaining Days: $remainingDays Days',
                                style: h3.copyWith(color: AppColors.red),
                              ),
                            ],
                          ),
                        )
                      : SubscriptionPlanCard(
                          title:
                              '${currentPlanDetails!.name} - ${'My_Current_Plan'.tr}',
                          duration:
                              _getDurationText(currentPlanDetails.duration),
                          price:
                              '\$${currentPlanDetails.price?.toStringAsFixed(2) ?? '0.00'}',
                          description: currentPlanDetails.description ??
                              'Enjoy your current subscription benefits.',
                          expiryDate: _formatDate(endDate),
                          remainingDays: remainingDays,
                          onSubscribe: () {
                            if (currentSubscription?.data?.id != null) {
                              controller.createPaymentSession(
                                  subscriptionId:
                                      currentSubscription!.data!.id!);
                              Get.snackbar(
                                'Renewed'.tr,
                                '${currentPlanDetails.name} ${'Has_Been_Renewed'.tr}',
                                backgroundColor: Colors.green,
                                colorText: AppColors.white,
                              );
                            }
                          },
                          isCurrentPlan: true,
                          buttonText: 'Renew_Plan'.tr,
                          buttonColor: AppColors.mainColor,
                          buttonTextColor: AppColors.white,
                          //titleTextColor: AppColors.white,
                        ),
                  sh30,
                  Text(
                    'Upgrade_Plan'.tr,
                    style: h2.copyWith(fontSize: 20, color: AppColors.black),
                  ),
                  sh12,
                ],
                // Available Plans Section
                ...controller.subscriptionPlans.map((plan) {
                  final isGoldPlan = plan.name == 'Gold Plan';
                  if (!_shouldShowButton(plan.name, currentPlan)) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      SubscriptionPlanCard(
                        title: plan.name ?? 'Unknown_Duration'.tr,
                        duration: _getDurationText(plan.duration),
                        price: '\$${plan.price?.toStringAsFixed(2) ?? '0.00'}',
                        description:
                            plan.description ?? 'No_Description_Available'.tr,
                        onSubscribe: () {
                          if (plan.id != null) {
                            controller.createPaymentSession(
                                subscriptionId: plan.id!);
                            // Get.snackbar(
                            //   'Success'.tr,
                            //   'You_Have_Subscribed_To'.tr + '${plan.name}!',
                            //   backgroundColor: Colors.green,
                            //   colorText: AppColors.white,
                            // );
                          } else {
                            Get.snackbar(
                              'Error'.tr,
                              'Unable_To_Subscribe_Plan_ID_Not_Found'.tr,
                              backgroundColor: AppColors.orange,
                              colorText: AppColors.white,
                            );
                          }
                        },
                        isCurrentPlan: plan.name == currentPlan,
                        buttonText: _getButtonText(plan.name, currentPlan),
                        titleTextColor:
                            isGoldPlan ? AppColors.green : AppColors.brownColor,
                        buttonColor:
                            isGoldPlan ? AppColors.green : AppColors.mainColor,
                        buttonTextColor: AppColors.white,
                        containerColor: isGoldPlan
                            ? Colors.orange[100]
                            : AppColors.white.withOpacity(0.9),
                        borderColor:
                            isGoldPlan ? Colors.orange : AppColors.black,
                      ),
                      if (isGoldPlan) ...[
                        sh8,
                        Center(
                          child: Text(
                            'Most_Popular'.tr,
                            style: h3.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      sh20,
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getButtonText(String? plan, String? currentPlan) {
    if (currentPlan == null) return 'Subscribe_Now'.tr;
    if (plan == currentPlan) return 'Renew_Plan'.tr;
    return '${'Upgrade_To'.tr}${plan?.split(' ')[0] ?? 'Plan'}';
  }

  bool _shouldShowButton(String? plan, String? currentPlan) {
    const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
    if (currentPlan == null) return true;
    final currentIndex = planOrder.indexOf(currentPlan);
    final planIndex = planOrder.indexOf(plan ?? '');
    return planIndex >= currentIndex;
  }

  String _getDurationText(int? duration) {
    if (duration == null) return 'Unknown_Duration'.tr;
    return duration == 1 ? 'One_Month'.tr : '$duration ${'Months_Suffix'.tr}';
  }

  String _formatDate(String? date) {
    if (date == null) return 'Not_Available'.tr;
    try {
      final parsedDate = DateTime.parse(date);
      return '${parsedDate.day} ${_getMonthName(parsedDate.month).tr} ${parsedDate.year}';
    } catch (e) {
      return 'Not_Available'.tr;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Month_Jan',
      'Month_Feb',
      'Month_Mar',
      'Month_Apr',
      'Month_May',
      'Month_Jun',
      'Month_Jul',
      'Month_Aug',
      'Month_Sep',
      'Month_Oct',
      'Month_Nov',
      'Month_Dec'
    ];
    return months[month - 1];
  }
}
