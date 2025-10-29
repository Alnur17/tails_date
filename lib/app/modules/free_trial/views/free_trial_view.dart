import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/subscription_plan_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/free_trial_controller.dart';

class FreeTrialView extends GetView<FreeTrialController> {
  const FreeTrialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 10,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.black,
                width: 4.0,
              ),
            ),
            borderRadius: BorderRadius.circular(30),
            color: AppColors.mainColorTwo,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: 'Start Your ', style: h1),
                  TextSpan(
                    text: '30-Days',
                    style: h1.copyWith(color: AppColors.secondaryOrangeColor),
                  ),
                  TextSpan(text: ' Free Trial', style: h1),
                ]),
              ),
              sh12,
              Text(
                'Experience all features for free for 30 days. ',
                style: h3,
              ),
              sh20,
              CustomButton(
                text: 'Start Free Trial',
                onPressed: () {},
              ),
              sh20,
              GestureDetector(
                onTap: (){
                  Get.to(()=> SubscriptionPlanView());
                },
                child: Text(
                  'Buy Subscription',
                  style: h3.copyWith(
                    color: AppColors.secondaryOrangeColor,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationThickness: 4,
                    decorationColor: AppColors.secondaryOrangeColor
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
