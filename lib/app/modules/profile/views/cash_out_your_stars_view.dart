import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/controllers/buy_star_controller.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_snack_bar.dart';

class CashOutYourStarsView extends StatefulWidget {
  final int starBalance;
  const CashOutYourStarsView( {super.key, required this.starBalance,});

  @override
  State<CashOutYourStarsView> createState() => _CashOutYourStarsViewState();
}

class _CashOutYourStarsViewState extends State<CashOutYourStarsView> {
  BuyStarController buyStarController = Get.put(BuyStarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Cash Out Your Stars'),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Turn your stars into cash. Each star equals \$0.01.',
                  style: h3),
              sh8,
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Star Balance',
                      style: h4.copyWith(
                          fontSize: 18, color: AppColors.brownColor),
                    ),
                    sh8,
                    Row(
                      children: [
                        Text('🌟'),
                        sw8,
                        Text(
                          '${widget.starBalance} Stars Remaining',
                          style: h2,
                        ),
                      ],
                    ),
                    sh8,
                    Text(
                      'which equals \$${widget.starBalance/100}',
                      style: h4,
                    ),
                  ],
                ),
              ),
              sh16,
              Text('Cash Out Details', style: h2),
              sh8,
              Text('Enter cash out amount:', style: h4),
              sh8,
              CustomTextField(
                controller: buyStarController.cashOutTEController,
                hintText: '\$0',
                keyboardType: TextInputType.number,
              ),
              sh8,
              Text(
                'Guidelines',
                style: h6,
              ),
              sh8,
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Text(
                    'Each star is worth \$0.01.',
                    style: h6,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Expanded(
                    child: Text(
                      'CashOuts are available on the 1st of each month.',
                      style: h6,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.black,
                    ),
                  ),
                  sw12,
                  Expanded(
                    child: Text(
                      'The cashOut amount will be less than what you spent on points.',
                      style: h6,
                    ),
                  ),
                ],
              ),
              sh24,
              CustomButton(
                text: 'Submit CashOut Request',
                onPressed: () async {
                  final amountText = buyStarController.cashOutTEController.text.trim();
                  if (amountText.isNotEmpty) {
                    final amount = int.tryParse(amountText);
                    if (amount != null && amount > 0) {
                      await buyStarController.casOutRequest(context, amount);
                    } else {
                      kSnackBar(
                        message: 'Please enter a valid positive amount.',
                        bgColor: AppColors.orange,
                      );
                    }
                  } else {
                    kSnackBar(
                      message: 'Please enter an amount.',
                      bgColor: AppColors.orange,
                    );
                  }
                },
              ),
              sh24,
              Text('CashOut Status', style: h2),
              sh8,
              Row(
                children: [
                  Text('Status:', style: h4),
                  sw8,
                  Text('No pending requests at the moment.', style: h4),
                ],
              ),
              sh16,
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      //   child: CustomButton(
      //     text: 'WithDraw',
      //     onPressed: () {
      //       Get.snackbar(
      //         'Need Approval',
      //         'You need to submit CashOut request first.',
      //         snackPosition: SnackPosition.TOP,
      //         duration: Duration(seconds: 5),
      //         backgroundColor: Colors.red,
      //         colorText: Colors.white,
      //       );
      //     },
      //   ),
      // ),
    );
  }


}
