import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/buy_star_controller.dart';

class BuyStarView extends StatefulWidget {
  const BuyStarView({super.key});

  @override
  State<BuyStarView> createState() => _BuyStarViewState();
}

class _BuyStarViewState extends State<BuyStarView> {
  final BuyStarController buyStarController = Get.put(BuyStarController());

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
              Obx(() => buyStarController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : buyStarController.starPlans.isEmpty
                      ? Text(
                          'No star plans available',
                          style: h5,
                        )
                      : Column(
                          children: [
                            ...buyStarController.starPlans
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final plan = entry.value;
                              return Column(
                                children: [
                                  StarContainer(
                                    numberOfStars:
                                        plan.stars?.toString() ?? '0',
                                    price: plan.price ?? 0.0,
                                    backgroundColor: buyStarController
                                                .selectedPlanIndex.value ==
                                            index
                                        ? AppColors.mainColor
                                        // : index == 0
                                        // ? AppColors.mainColor
                                        : AppColors.transparent,
                                    isSelected: buyStarController
                                            .selectedPlanIndex.value ==
                                        index,
                                    onTap: () {
                                      buyStarController.selectPlan(index);
                                    },
                                  ),
                                  if (index == 0) ...[
                                    sh8,
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Your first stars are discounted for a limited time!',
                                        style: h6,
                                      ),
                                    ),
                                  ],
                                  sh16,
                                ],
                              );
                            }).toList(),
                            sh30,
                            CustomButton(
                              text: 'Buy Stars',
                              onPressed: buyStarController.buySelectedPlan,
                              backgroundColor: AppColors.mainColor,
                              textStyle: h3.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        )),
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
  final bool isSelected;
  final VoidCallback? onTap;

  const StarContainer({
    super.key,
    required this.numberOfStars,
    required this.price,
    this.backgroundColor,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryOrangeColor
                : AppColors.secondaryOrangeColor,
            width: isSelected ? 2 : 1,
          ),
          color: backgroundColor ?? AppColors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(
              AppImages.starFilled,
              scale: 4,
            ),
            sw8,
            Text(
              '$numberOfStars Stars',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Spacer(),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Buy Stars'),
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
//       body: Container(
//         margin: EdgeInsets.all(16),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.black),
//           color: AppColors.white,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Image.asset(
//                 AppImages.starCard,
//                 scale: 4,
//               ),
//               sh12,
//               Text(
//                 '🌟 Add Star to your balance to send gifts 🌟',
//                 style: h4,
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '99',
//                 price: 0.99,
//                 backgroundColor: AppColors.mainColor,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Your first stars are discounted for a limited time!',
//                   style: h6,
//                 ),
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '75',
//                 price: 0.99,
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '235',
//                 price: 2.99,
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '490',
//                 price: 5.99,
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '830',
//                 price: 9.99,
//               ),
//               sh16,
//               StarContainer(
//                 numberOfStars: '1000',
//                 price: 12.99,
//               ),
//               sh30,
//               CustomButton(
//                 text: 'Buy Stars',
//                 onPressed: () {},
//                 backgroundColor: AppColors.mainColor,
//                 textStyle: h3.copyWith(
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class StarContainer extends StatelessWidget {
//   final String numberOfStars;
//   final double price;
//   final Color? backgroundColor;
//
//   const StarContainer({
//     super.key,
//     required this.numberOfStars,
//     required this.price,
//     this.backgroundColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.secondaryOrangeColor),
//         color: backgroundColor ?? AppColors.transparent,
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             AppImages.starFilled,
//             scale: 4,
//           ),
//           sw8,
//           Text('$numberOfStars Stars'),
//           Spacer(),
//           Text('\$$price'),
//         ],
//       ),
//     );
//   }
// }
