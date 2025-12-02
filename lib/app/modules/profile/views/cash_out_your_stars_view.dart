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

  const CashOutYourStarsView({super.key, required this.starBalance});

  @override
  State<CashOutYourStarsView> createState() => _CashOutYourStarsViewState();
}

class _CashOutYourStarsViewState extends State<CashOutYourStarsView> {
  BuyStarController buyStarController = Get.put(BuyStarController());

  @override
  void initState() {
    super.initState();
    buyStarController.getCashOutStatus();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    //final bool isCashOutWindowOpen = now.day >= 1 && now.day <= 7;
    final bool isCashOutWindowOpen = now.day == 1 ;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Cash_Out_Your_Stars'.tr),
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
              Text('Turn_Stars_Into_Cash'.tr, style: h3),
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
                      'Your_Star_Balance'.tr,
                      style: h4.copyWith(
                          fontSize: 18, color: AppColors.brownColor),
                    ),
                    sh8,
                    Row(
                      children: [
                        Text('🌟'),
                        sw8,
                        Expanded(
                          child: Text(
                            '${widget.starBalance} ${'Stars_Remaining'.tr}',
                            style: h2,
                          ),
                        ),
                      ],
                    ),
                    sh8,
                    Text(
                      'which equals \$${widget.starBalance / 100}',
                      style: h4,
                    ),
                  ],
                ),
              ),
              sh16,
              Text('Cash_Out_Details'.tr, style: h2),
              sh8,
              Text('Enter_Cash_Out_Amount'.tr, style: h4),
              sh8,
              CustomTextField(
                controller: buyStarController.cashOutTEController,
                hintText: 'Cash_Out_Amount_Hint'.tr,
                keyboardType: TextInputType.number,
              ),
              sh8,
              Text(
                'Guidelines'.tr,
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
                    'Star_Value'.tr,
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
                      'CashOut_Availability'.tr,
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
                      'CashOut_Amount_Less'.tr,
                      style: h6,
                    ),
                  ),
                ],
              ),
              sh24,
              CustomButton(
                text: 'Submit_CashOut_Request'.tr,
                onPressed: isCashOutWindowOpen
                    ? () async {
                        final amountText =
                            buyStarController.cashOutTEController.text.trim();
                        if (amountText.isNotEmpty) {
                          final amount = int.tryParse(amountText);
                          if (amount != null && amount > 0) {
                            if (amount <= widget.starBalance / 100) {
                              await buyStarController.casOutRequest(
                                  context, amount);
                              await buyStarController.getCashOutStatus();
                            } else {
                              kSnackBar(
                                message: 'Amount_Exceeds_Balance'.tr,
                                bgColor: AppColors.orange,
                              );
                            }
                          } else {
                            kSnackBar(
                              message: 'Enter_Valid_Amount'.tr,
                              bgColor: AppColors.orange,
                            );
                          }
                        } else {
                          kSnackBar(
                            message: 'Enter_Amount'.tr,
                            bgColor: AppColors.orange,
                          );
                        }
                      }
                    : (){
                  kSnackBar(
                    message: 'CashOut are available on the 1st day of each month',
                    bgColor: AppColors.orange,
                  );
                }, // disabled outside 1-7
              ),
              sh24,
              Text('CashOut_Status'.tr, style: h2),
              sh8,
              Obx(() => buyStarController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : buyStarController.cashOutStatusList.isEmpty
                      ? Row(
                          children: [
                            Text('Status_Label'.tr, style: h4),
                            sw8,
                            Expanded(
                                child:
                                    Text('No_Pending_Requests'.tr, style: h4)),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: buyStarController.cashOutStatusList.length,
                          itemBuilder: (context, index) {
                            final status =
                                buyStarController.cashOutStatusList[index];
                            return Card(
                              color: AppColors.white,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Amount_Label'.tr, style: h4),
                                        sw8,
                                        Text('\$${status.amount}', style: h4),
                                      ],
                                    ),
                                    sh8,
                                    Row(
                                      children: [
                                        Text('Stars_Label'.tr, style: h4),
                                        sw8,
                                        Text('${status.stars} 🌟', style: h4),
                                      ],
                                    ),
                                    sh8,
                                    Row(
                                      children: [
                                        Text('Status_Label'.tr, style: h4),
                                        sw8,
                                        Text(
                                          status.status ?? 'Unknown'.tr,
                                          style: h4.copyWith(
                                            color: status.status == 'approved'
                                                ? AppColors.green
                                                : status.status == 'rejected'
                                                    ? AppColors.red
                                                    : AppColors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (status.rejectionReason != null &&
                                        status.rejectionReason is String) ...[
                                      sh8,
                                      Row(
                                        children: [
                                          Text('Rejection_Reason_Label'.tr,
                                              style: h4),
                                          sw8,
                                          Expanded(
                                            child: Text(
                                              status.rejectionReason,
                                              style: h4.copyWith(
                                                  color: AppColors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    sh8,
                                    Text(
                                      '${'Requested_On_Label'.tr} ${status.createdAt?.toLocal().toString().split('.')[0] ?? 'Not_Available'.tr}',
                                      style: h6,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
              sh16,
            ],
          ),
        ),
      ),
    );
  }
}
