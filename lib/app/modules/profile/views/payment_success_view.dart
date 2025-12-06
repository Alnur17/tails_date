import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class PaymentSuccessView extends GetView {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.paymentSuccess, scale: 4),
              sh30,
              Text('Payment_Successful'.tr, style: h3.copyWith(fontSize: 22)), // Updated to use translation
              sh30,
              // Text('Your payment was successful!',style: h5,textAlign: TextAlign.center,),
              CustomButton(
                text: 'Back_To_Home'.tr, // Updated to use translation
                onPressed: () {
                  Get.offAll(() => DashboardView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}