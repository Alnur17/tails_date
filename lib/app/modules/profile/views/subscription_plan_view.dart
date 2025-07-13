// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/views/widgets/subscription_plan_card.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
//
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
//
// class SubscriptionPlanView extends StatefulWidget {
//   const SubscriptionPlanView({super.key});
//
//   @override
//   State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
// }
//
// class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
//   String? currentPlan; // Track the current subscription plan
//
//   // Helper function to determine the button text
//   String _getButtonText(String plan) {
//     if (currentPlan == null) return 'Subscribe Now';
//     if (plan == currentPlan) return 'Renew Plan';
//     return 'Upgrade to ${plan.split(' ')[0]}';
//   }
//
//   // Helper function to determine if the button should be shown
//   bool _shouldShowButton(String plan) {
//     const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
//     if (currentPlan == null)
//       return true; // Show all plans for unsubscribed users
//     final currentIndex = planOrder.indexOf(currentPlan!);
//     final planIndex = planOrder.indexOf(plan);
//     return planIndex >= currentIndex; // Show only the current or higher plans
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Subscription Plan'),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (currentPlan != null) ...[
//                 // My Current Plan Section
//                 Text(
//                   'My Current Plan',
//                   style: h2.copyWith(fontSize: 20),
//                 ),
//                 sh12,
//                 SubscriptionPlanCard(
//                   title: currentPlan!,
//                   duration: currentPlan == 'Silver Plan'
//                       ? '1 Month'
//                       : currentPlan == 'Gold Plan'
//                           ? '3 Months'
//                           : '1 Year',
//                   price: currentPlan == 'Silver Plan'
//                       ? '\$9.99'
//                       : currentPlan == 'Gold Plan'
//                           ? '\$24.99'
//                           : '\$99.99',
//                   description: 'Enjoy your current subscription benefits.',
//                   expiryDate: '31 Dec 2024',
//                   remainingDays: 23,
//                   onSubscribe: () {
//                     Get.snackbar(
//                       'Renewed',
//                       'Your $currentPlan has been renewed!',
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                     );
//                   },
//                   isCurrentPlan: true,
//                   buttonText: _getButtonText(currentPlan!),
//                 ),
//                 sh30,
//                 // Upgrade Plan Section
//                 Text(
//                   'Upgrade Plan',
//                   style: h2.copyWith(fontSize: 20),
//                 ),
//               ],
//               if (_shouldShowButton('Silver Plan'))
//                 SubscriptionPlanCard(
//                   title: 'Silver Plan',
//                   duration: '1 Month',
//                   price: '\$9.99',
//                   description:
//                       'Perfect for trying out our features at a low commitment.',
//                   onSubscribe: () {
//                     setState(() {
//                       currentPlan = 'Silver Plan';
//                     });
//                     Get.snackbar(
//                       'Success',
//                       'You have subscribed to the Silver Plan!',
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                     );
//                   },
//                   isCurrentPlan: currentPlan == 'Silver Plan',
//                   buttonText: _getButtonText('Silver Plan'),
//                 ),
//               sh20,
//               if (_shouldShowButton('Gold Plan'))
//                 SubscriptionPlanCard(
//                   title: 'Gold Plan',
//                   duration: '3 Months',
//                   price: '\$24.99',
//                   description:
//                       'Our most popular plan for those who love value and flexibility!',
//                   onSubscribe: () {
//                     setState(() {
//                       currentPlan = 'Gold Plan';
//                     });
//                     Get.snackbar(
//                       'Success',
//                       'You have upgraded to the Gold Plan!',
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                     );
//                   },
//                   titleTextColor: AppColors.green,
//                   buttonColor: AppColors.green,
//                   buttonTextColor: AppColors.white,
//                   isCurrentPlan: currentPlan == 'Gold Plan',
//                   buttonText: _getButtonText('Gold Plan'),
//                 ),
//               sh20,
//               if (_shouldShowButton('Platinum Plan'))
//                 SubscriptionPlanCard(
//                   title: 'Platinum Plan',
//                   duration: '1 Year',
//                   price: '\$99.99',
//                   description:
//                       'Go all-in for maximum savings and exclusive perks!',
//                   onSubscribe: () {
//                     setState(() {
//                       currentPlan = 'Platinum Plan';
//                     });
//                     Get.snackbar(
//                       'Success',
//                       'You have upgraded to the Platinum Plan!',
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                     );
//                   },
//                   isCurrentPlan: currentPlan == 'Platinum Plan',
//                   buttonText: _getButtonText('Platinum Plan'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/views/widgets/subscription_plan_card.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
//
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../controllers/subscription_plan_controller.dart';
//
// class SubscriptionPlanView extends StatefulWidget {
//   const SubscriptionPlanView({super.key});
//
//   @override
//   State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
// }
//
// class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
//   final SubscriptionPlanController subscriptionPlanController = Get.put(SubscriptionPlanController());
//   String? currentPlan; // Track the current subscription plan
//
//   // Helper function to determine the button text
//   String _getButtonText(String plan) {
//     if (currentPlan == null) return 'Subscribe Now';
//     if (plan == currentPlan) return 'Renew Plan';
//     return 'Upgrade to ${plan.split(' ')[0]}';
//   }
//
//   // Helper function to determine if the button should be shown
//   bool _shouldShowButton(String plan) {
//     const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
//     if (currentPlan == null) return true; // Show all plans for unsubscribed users
//     final currentIndex = planOrder.indexOf(currentPlan!);
//     final planIndex = planOrder.indexOf(plan);
//     return planIndex >= currentIndex; // Show only the current or higher plans
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Subscription Plan'),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (subscriptionPlanController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (subscriptionPlanController.errorMessage.value.isNotEmpty) {
//           return Center(child: Text(subscriptionPlanController.errorMessage.value, style: h3));
//         }
//         if (subscriptionPlanController.subscriptionPlans.isEmpty) {
//           return Center(child: Text('No subscription plans available', style: h3));
//         }
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (currentPlan != null) ...[
//                   // My Current Plan Section
//                   Text(
//                     'My Current Plan',
//                     style: h2.copyWith(fontSize: 20),
//                   ),
//                   sh12,
//                   SubscriptionPlanCard(
//                     title: currentPlan!,
//                     duration: currentPlan == 'Silver Plan'
//                         ? '1 Month'
//                         : currentPlan == 'Gold Plan'
//                         ? '3 Months'
//                         : '1 Year',
//                     price: currentPlan == 'Silver Plan'
//                         ? '\$9.99'
//                         : currentPlan == 'Gold Plan'
//                         ? '\$24.99'
//                         : '\$99.99',
//                     description: 'Enjoy your current subscription benefits.',
//                     expiryDate: '31 Dec 2024',
//                     remainingDays: 23,
//                     onSubscribe: () {
//                       Get.snackbar(
//                         'Renewed',
//                         'Your $currentPlan has been renewed!',
//                         backgroundColor: Colors.green,
//                         colorText: Colors.white,
//                       );
//                     },
//                     isCurrentPlan: true,
//                     buttonText: _getButtonText(currentPlan!),
//                   ),
//                   sh30,
//                   // Upgrade Plan Section
//                   Text(
//                     'Upgrade Plan',
//                     style: h2.copyWith(fontSize: 20),
//                   ),
//                 ],
//                 ...subscriptionPlanController.subscriptionPlans.map((plan) {
//                   if (!_shouldShowButton(plan.name ?? '')) return const SizedBox.shrink();
//                   return Column(
//                     children: [
//                       SubscriptionPlanCard(
//                         title: plan.name ?? 'Unknown Plan',
//                         duration: '${plan.duration ?? 0} ${plan.duration == 1 ? 'Month' : 'Months'}',
//                         price: '\$${plan.price?.toStringAsFixed(2) ?? '0.00'}',
//                         description: plan.description ?? 'No description available',
//                         onSubscribe: () {
//                           if (plan.id != null) {
//                             subscriptionPlanController.createPaymentSession(subscriptionId: plan.id!);
//                             setState(() {
//                               currentPlan = plan.name;
//                             });
//                           } else {
//                             Get.snackbar(
//                               'Error',
//                               'Unable to subscribe: Plan ID not found',
//                               backgroundColor: AppColors.orange,
//                               colorText: AppColors.white,
//                             );
//                           }
//                         },
//                         isCurrentPlan: currentPlan == plan.name,
//                         buttonText: _getButtonText(plan.name ?? ''),
//                         titleTextColor: plan.name == 'Gold Plan' ? AppColors.green : null,
//                         buttonColor: plan.name == 'Gold Plan' ? AppColors.green : null,
//                         buttonTextColor: plan.name == 'Gold Plan' ? AppColors.white : null,
//                       ),
//                       sh20,
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/views/widgets/subscription_plan_card.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../controllers/subscription_plan_controller.dart';
//
// class SubscriptionPlanView extends StatefulWidget {
//   const SubscriptionPlanView({super.key});
//
//   @override
//   State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
// }
//
// class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
//   final SubscriptionPlanController subscriptionPlanController = Get.put(SubscriptionPlanController());
//
//   // Helper function to determine the button text
//   String _getButtonText(String plan, String? currentPlan) {
//     if (currentPlan == null) return 'Subscribe Now';
//     if (plan == currentPlan) return 'Renew Plan';
//     return 'Upgrade to ${plan.split(' ')[0]}';
//   }
//
//   // Helper function to determine if the button should be shown
//   bool _shouldShowButton(String plan, String? currentPlan) {
//     const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
//     if (currentPlan == null) return true; // Show all plans for unsubscribed users
//     final currentIndex = planOrder.indexOf(currentPlan);
//     final planIndex = planOrder.indexOf(plan);
//     return planIndex >= currentIndex; // Show only the current or higher plans
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Subscription Plans'),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (subscriptionPlanController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (subscriptionPlanController.errorMessage.value.isNotEmpty) {
//           return Center(child: Text(subscriptionPlanController.errorMessage.value, style: h3));
//         }
//         if (subscriptionPlanController.subscriptionPlans.isEmpty) {
//           return Center(child: Text('No subscription plans available', style: h3));
//         }
//
//         // Get current subscription and plan details
//         final currentSubscription = subscriptionPlanController.myCurrentSubscription.value;
//         final currentPlan = currentSubscription?.data?.plan;
//         final expiryDate = currentSubscription?.data?.endDate;
//         final status = currentSubscription?.data?.status;
//         final remainingDays = expiryDate != null && status == 'active'
//             ? expiryDate.difference(DateTime.now()).inDays
//             : null;
//
//         // Find the matching plan in subscriptionPlans to get duration and price
//         final currentPlanDetails = subscriptionPlanController.subscriptionPlans
//             .firstWhereOrNull((plan) => plan.name == currentPlan);
//
//         // Check if there is an active subscription
//         final hasActiveSubscription = currentPlan != null && currentPlanDetails != null &&
//             status == 'active' && remainingDays != null && remainingDays > 0;
//
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (!hasActiveSubscription) ...[
//                   // Display all plans for unsubscribed users
//                   ...subscriptionPlanController.subscriptionPlans.map((plan) {
//                     final isGoldPlan = plan.name == 'Gold Plan';
//                     return Column(
//                       children: [
//                         SubscriptionPlanCard(
//                           title: plan.name ?? 'Unknown Plan',
//                           duration: '${plan.duration ?? 0} ${plan.duration == 1 ? 'Month' : 'Months'}',
//                           price: '\$${plan.price?.toStringAsFixed(2) ?? '0.00'}',
//                           description: plan.description ?? 'No description available',
//                           onSubscribe: () {
//                             if (plan.id != null) {
//                               subscriptionPlanController.createPaymentSession(subscriptionId: plan.id!);
//                             } else {
//                               Get.snackbar(
//                                 'Error',
//                                 'Unable to subscribe: Plan ID not found',
//                                 backgroundColor: AppColors.orange,
//                                 colorText: AppColors.white,
//                               );
//                             }
//                           },
//                           buttonText: 'Subscribe Now',
//                           buttonColor: AppColors.mainColor,
//                           titleTextColor: isGoldPlan ? AppColors.green : null,
//                           buttonTextColor: isGoldPlan ? AppColors.white : null,
//                           containerColor: isGoldPlan ? Colors.orange[100] : null,
//                           borderColor: isGoldPlan ? Colors.orange : null,
//                         ),
//                         if (isGoldPlan) sh8,
//                         if (isGoldPlan)
//                           Center(
//                             child: Text(
//                               'Most Popular',
//                               style: h3.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         sh20,
//                       ],
//                     );
//                   }),
//                 ] else if (currentPlanDetails != null) ...[
//                   // Display current plan and upgrade options for subscribed users
//                   Text(
//                     'My Current Plan',
//                     style: h2.copyWith(fontSize: 20),
//                   ),
//                   sh12,
//                   SubscriptionPlanCard(
//                     title: '$currentPlan - My Current Plan',
//                     duration: '${currentPlanDetails.duration ?? 0} ${currentPlanDetails.duration == 1 ? 'Month' : 'Months'}',
//                     price: '\$${currentPlanDetails.price?.toStringAsFixed(2) ?? '0.00'}',
//                     description: currentPlanDetails.description ?? 'Enjoy your current subscription benefits.',
//                     expiryDate: expiryDate?.toString().split(' ')[0],
//                     remainingDays: remainingDays,
//                     onSubscribe: () {
//                       Get.snackbar(
//                         'Renewed',
//                         'Your $currentPlan has been renewed!',
//                         backgroundColor: Colors.green,
//                         colorText: Colors.white,
//                       );
//                     },
//                     isCurrentPlan: true,
//                     buttonText: 'Renew Plan',
//                     buttonColor: AppColors.mainColor,
//                   ),
//                   sh30,
//                   Text(
//                     'Upgrade Plan',
//                     style: h2.copyWith(fontSize: 20),
//                   ),
//                   sh12,
//                   ...subscriptionPlanController.subscriptionPlans.where((plan) => plan.name != currentPlan).map((plan) {
//                     final isGoldPlan = plan.name == 'Gold Plan';
//                     return Column(
//                       children: [
//                         SubscriptionPlanCard(
//                           title: plan.name ?? 'Unknown Plan',
//                           duration: '${plan.duration ?? 0} ${plan.duration == 1 ? 'Month' : 'Months'}',
//                           price: '\$${plan.price?.toStringAsFixed(2) ?? '0.00'}',
//                           description: plan.description ?? 'No description available',
//                           onSubscribe: () {
//                             if (plan.id != null) {
//                               subscriptionPlanController.createPaymentSession(subscriptionId: plan.id!);
//                             } else {
//                               Get.snackbar(
//                                 'Error',
//                                 'Unable to subscribe: Plan ID not found',
//                                 backgroundColor: AppColors.orange,
//                                 colorText: AppColors.white,
//                               );
//                             }
//                           },
//                           buttonText: 'Upgrade to ${plan.name?.split(' ')[0]}',
//                           buttonColor: AppColors.mainColor,
//                           titleTextColor: isGoldPlan ? AppColors.green : null,
//                           buttonTextColor: isGoldPlan ? AppColors.white : null,
//                           containerColor: isGoldPlan ? Colors.orange[100] : null,
//                           borderColor: isGoldPlan ? Colors.orange : null,
//                         ),
//                         if (isGoldPlan) sh8,
//                         if (isGoldPlan)
//                           Center(
//                             child: Text(
//                               'Most Popular',
//                               style: h3.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         sh20,
//                       ],
//                     );
//                   }),
//                 ],
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }


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
    final SubscriptionPlanController controller = Get.put(SubscriptionPlanController());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Subscription Plans'),
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
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: h3));
        }
        if (controller.subscriptionPlans.isEmpty) {
          return Center(child: Text('No subscription plans available', style: h3));
        }

        final currentSubscription = controller.myCurrentSubscription.value;
        final currentPlan = currentSubscription?.data?.plan?.name;
        final currentPlanDetails = currentSubscription?.data?.plan;
        final endDate = currentSubscription?.data?.endDate;
        final status = currentSubscription?.data?.status;
        final parsedEndDate = endDate != null ? DateTime.tryParse(endDate) : null;
        final remainingDays = parsedEndDate != null && status == 'active'
            ? parsedEndDate.difference(DateTime.now()).inDays
            : null;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Plan Section
                if (currentPlanDetails != null && status == 'active' && remainingDays != null && remainingDays > 0) ...[
                  Text(
                    'My Current Plan',
                    style: h2.copyWith(fontSize: 20, color: AppColors.white),
                  ),
                  sh12,
                  SubscriptionPlanCard(
                    title: '${currentPlanDetails.name} - My Current Plan',
                    duration: _getDurationText(currentPlanDetails.duration),
                    price: '\$${currentPlanDetails.price?.toStringAsFixed(2) ?? '0.00'}',
                    description: currentPlanDetails.description ?? 'Enjoy your current subscription benefits.',
                    expiryDate: _formatDate(endDate),
                    remainingDays: remainingDays,
                    onSubscribe: () {
                      if (currentSubscription?.data?.id != null) {
                        controller.createPaymentSession(subscriptionId: currentSubscription!.data!.id!);
                        Get.snackbar(
                          'Renewed',
                          'Your ${currentPlanDetails.name} has been renewed!',
                          backgroundColor: Colors.green,
                          colorText: AppColors.white,
                        );
                      }
                    },
                    isCurrentPlan: true,
                    buttonText: 'Renew Plan',
                    buttonColor: AppColors.mainColor,
                    buttonTextColor: AppColors.white,
                    titleTextColor: AppColors.white,
                  ),
                  sh30,
                  Text(
                    'Upgrade Plan',
                    style: h2.copyWith(fontSize: 20, color: AppColors.white),
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
                        title: plan.name ?? 'Unknown Plan',
                        duration: _getDurationText(plan.duration),
                        price: '\$${plan.price?.toStringAsFixed(2) ?? '0.00'}',
                        description: plan.description ?? 'No description available',
                        onSubscribe: () {
                          if (plan.id != null) {
                            controller.createPaymentSession(subscriptionId: plan.id!);
                            Get.snackbar(
                              'Success',
                              'You have subscribed to ${plan.name}!',
                              backgroundColor: Colors.green,
                              colorText: AppColors.white,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Unable to subscribe: Plan ID not found',
                              backgroundColor: AppColors.orange,
                              colorText: AppColors.white,
                            );
                          }
                        },
                        isCurrentPlan: plan.name == currentPlan,
                        buttonText: _getButtonText(plan.name, currentPlan),
                        titleTextColor: isGoldPlan ? AppColors.green : AppColors.white,
                        buttonColor: isGoldPlan ? AppColors.green : AppColors.mainColor,
                        buttonTextColor: AppColors.white,
                        containerColor: isGoldPlan ? Colors.orange[100] : AppColors.white.withOpacity(0.9),
                        borderColor: isGoldPlan ? Colors.orange : AppColors.black,
                      ),
                      if (isGoldPlan) ...[
                        sh8,
                        Center(
                          child: Text(
                            'Most Popular',
                            style: h3.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      sh20,
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getButtonText(String? plan, String? currentPlan) {
    if (currentPlan == null) return 'Subscribe Now';
    if (plan == currentPlan) return 'Renew Plan';
    return 'Upgrade to ${plan?.split(' ')[0] ?? 'Plan'}';
  }

  bool _shouldShowButton(String? plan, String? currentPlan) {
    const planOrder = ['Silver Plan', 'Gold Plan', 'Platinum Plan'];
    if (currentPlan == null) return true;
    final currentIndex = planOrder.indexOf(currentPlan);
    final planIndex = planOrder.indexOf(plan ?? '');
    return planIndex >= currentIndex;
  }

  String _getDurationText(int? duration) {
    if (duration == null) return 'Unknown';
    return duration == 1 ? '1 Month' : '$duration Months';
  }

  String _formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final parsedDate = DateTime.parse(date);
      return '${parsedDate.day} ${_getMonthName(parsedDate.month)} ${parsedDate.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}