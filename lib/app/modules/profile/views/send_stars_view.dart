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
  final String id;
  final bool isFromStory; // 👈 New flag to check source (story or post)

  const SendStarsView({
    super.key,
    required this.id,
    this.isFromStory = false, // default false → means from post
  });

  @override
  Widget build(BuildContext context) {
    final SendStarsController sendStarsController = Get.put(SendStarsController());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Send_Stars'.tr), // Updated to use translation
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
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
              Text('Enjoyed_This_Post'.tr, style: h3), // Updated to use translation
              sh24,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.black),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(AppImages.starCardTwo, scale: 4),
                    sw12,
                    Expanded(
                      child: Text(
                        'Show_Appreciation'.tr, // Updated to use translation
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
                      text: 'Star_Amount_50'.tr, // Updated to use translation
                      isSelected: sendStarsController.selectedAmount.value == 50,
                      onTap: () => sendStarsController.selectAmount(50),
                    ),
                    TappableContainer(
                      iconPath: AppImages.starFilled,
                      text: 'Star_Amount_100'.tr, // Updated to use translation
                      isSelected: sendStarsController.selectedAmount.value == 100,
                      onTap: () => sendStarsController.selectAmount(100),
                    ),
                    TappableContainer(
                      iconPath: AppImages.starFilled,
                      text: 'Star_Amount_200'.tr, // Updated to use translation
                      isSelected: sendStarsController.selectedAmount.value == 200,
                      onTap: () => sendStarsController.selectAmount(200),
                    ),
                  ],
                );
              }),
              sh8,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Custom_Amount'.tr, // Updated to use translation
                  style: h3.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              sh8,
              CustomTextField(
                hintText: 'Send_Stars'.tr, // Updated to use translation
                preIcon: Image.asset(AppImages.starFilled, scale: 4),
                controller: sendStarsController.customAmountController,
              ),
              sh24,
              CustomButton(
                text: 'Send_Stars_Button'.tr, // Updated to use translation
                onPressed: () {
                  final enteredAmount = sendStarsController.getSelectedAmount();
                  if (enteredAmount.isNotEmpty &&
                      int.tryParse(enteredAmount) != null &&
                      int.parse(enteredAmount) > 0) {
                    final amount = int.parse(enteredAmount);

                    if (isFromStory) {
                      sendStarsController.sendStarsFromStory(id, amount, context);
                    } else {
                      sendStarsController.sendStars(id, amount, context);
                    }

                    log('Sending $enteredAmount stars! (from ${isFromStory ? "Story" : "Post"})');
                  } else {
                    Get.snackbar(
                      'Invalid_Amount'.tr, // Updated to use translation
                      'Please_Enter_Valid_Stars'.tr, // Updated to use translation
                      backgroundColor: AppColors.red,
                      colorText: AppColors.white,
                    );
                  }
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
        width: width ?? 90,
        padding: const EdgeInsets.symmetric(vertical: 10),
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
            sw5,
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

// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/controllers/send_stars_controller.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/widgets/custom_textfield.dart';
//
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_button.dart';
//
// class SendStarsView extends GetView<SendStarsController> {
//   final String? id;
//   const SendStarsView({super.key, required this.id});
//
//   @override
//   Widget build(BuildContext context) {
//     final SendStarsController sendStarsController = Get.put(SendStarsController());
//
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: Text('Send Stars', style: h2.copyWith(color: AppColors.white)),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Image.asset(AppImages.back, scale: 4),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: AppColors.black.withOpacity(0.2)),
//           gradient: LinearGradient(
//             colors: AppColors.gradientColor,
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Show Your Appreciation',
//                 style: h2.copyWith(fontWeight: FontWeight.bold),
//               ),
//               sh8,
//               Text(
//                 'Send stars to support the creator!',
//                 style: h5.copyWith(color: AppColors.grey),
//               ),
//               sh24,
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.black.withOpacity(0.2)),
//                   color: AppColors.white.withOpacity(0.9),
//                 ),
//                 child: Row(
//                   children: [
//                     Image.asset(AppImages.starCardTwo, scale: 3.5),
//                     sw16,
//                     Expanded(
//                       child: Text(
//                         'Your stars help creators keep making amazing content!',
//                         style: h5.copyWith(fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               sh24,
//               Text(
//                 'Select Amount',
//                 style: h4.copyWith(fontWeight: FontWeight.w700),
//               ),
//               sh16,
//               Obx(() => Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: [
//                   TappableContainer(
//                     iconPath: AppImages.starFilled,
//                     text: '50',
//                     isSelected: sendStarsController.selectedAmount.value == 50,
//                     onTap: () => sendStarsController.selectAmount(50),
//                   ),
//                   TappableContainer(
//                     iconPath: AppImages.starFilled,
//                     text: '100',
//                     isSelected: sendStarsController.selectedAmount.value == 100,
//                     onTap: () => sendStarsController.selectAmount(100),
//                   ),
//                   TappableContainer(
//                     iconPath: AppImages.starFilled,
//                     text: '200',
//                     isSelected: sendStarsController.selectedAmount.value == 200,
//                     onTap: () => sendStarsController.selectAmount(200),
//                   ),
//                 ],
//               )),
//               sh24,
//               Text(
//                 'Custom Amount',
//                 style: h4.copyWith(fontWeight: FontWeight.w700),
//               ),
//               sh12,
//               CustomTextField(
//                 hintText: 'Enter Stars Amount',
//                 preIcon: Image.asset(AppImages.starFilled, scale: 4),
//                 controller: sendStarsController.customAmountController,
//                 keyboardType: TextInputType.number,
//                 onChange: (value) {
//                   if (value.isNotEmpty) {
//                     sendStarsController.selectAmount(0); // Clear preset selection
//                   }
//                 },
//               ),
//               sh30,
//               CustomButton(
//                 text: 'Send Stars 🌟',
//                 onPressed: () {
//                   final enteredAmount = sendStarsController.getSelectedAmount();
//                   if (enteredAmount.isEmpty || int.tryParse(enteredAmount) == null || int.parse(enteredAmount) <= 0) {
//                     Get.snackbar(
//                       'Invalid Amount',
//                       'Please enter a valid number of stars',
//                       backgroundColor: AppColors.red,
//                       colorText: AppColors.white,
//                     );
//                     return;
//                   }
//                   final amount = int.parse(enteredAmount);
//                   Get.defaultDialog(
//                     title: 'Confirm Stars',
//                     titleStyle: h3.copyWith(color: AppColors.black),
//                     content: Text(
//                       'Send $enteredAmount stars to this creator?',
//                       style: h5,
//                       textAlign: TextAlign.center,
//                     ),
//                     confirm: TextButton(
//                       onPressed: () {
//                         Get.back();
//                         sendStarsController.sendStars(id ?? '', amount);
//                         log('Sending $enteredAmount stars!');
//                       },
//                       child: Text('Send', style: h5.copyWith(color: AppColors.green)),
//                     ),
//                     cancel: TextButton(
//                       onPressed: () => Get.back(),
//                       child: Text('Cancel', style: h5.copyWith(color: AppColors.red)),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TappableContainer extends StatelessWidget {
//   final double? width;
//   final double? borderRadius;
//   final Color? borderColor;
//   final String iconPath;
//   final String text;
//   final bool isSelected;
//   final TextStyle? textStyle;
//   final VoidCallback onTap;
//
//   const TappableContainer({
//     super.key,
//     this.width,
//     this.borderRadius,
//     this.borderColor,
//     required this.iconPath,
//     required this.text,
//     required this.isSelected,
//     this.textStyle,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width ?? 100,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius ?? 12),
//           border: Border.all(
//             color: isSelected
//                 ? AppColors.orange.withOpacity(0.8)
//                 : AppColors.black.withOpacity(0.2),
//             width: isSelected ? 2 : 1,
//           ),
//           color: isSelected ? AppColors.orange.withOpacity(0.1) : AppColors.white,
//           boxShadow: isSelected
//               ? [
//             BoxShadow(
//               color: AppColors.orange.withOpacity(0.3),
//               blurRadius: 8,
//               spreadRadius: 1,
//             ),
//           ]
//               : [],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               iconPath,
//               scale: 3.5,
//               color: isSelected ? AppColors.orange : null,
//             ),
//             sw8,
//             Text(
//               text,
//               style: (textStyle ?? h4).copyWith(
//                 color: isSelected ? AppColors.black : AppColors.grey,
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }