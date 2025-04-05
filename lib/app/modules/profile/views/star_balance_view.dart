import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/buy_star_view.dart';
import 'package:tails_date/app/modules/profile/views/cash_out_your_stars_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class StarBalanceView extends StatefulWidget {
  const StarBalanceView({super.key});

  @override
  State<StarBalanceView> createState() => _StarBalanceViewState();
}

class _StarBalanceViewState extends State<StarBalanceView> {
  bool showReceivedStars = true;

  final List<Map<String, dynamic>> dummyData = List.generate(
    10,
    (index) => {
      'id': index + 1,
      'fullName': '@Happy_Paws',
      'numberOfStars': 10,
      'date': '02 Dec, 2024',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Star Balance'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'My Current Star Balance',
              style: h3.copyWith(fontWeight: FontWeight.w700),
            ),
            sh12,
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
                    'Track and manage stars here',
                    style:
                        h4.copyWith(fontSize: 18, color: AppColors.brownColor),
                  ),
                  sh8,
                  Row(
                    children: [
                      Text('🌟'),
                      sw8,
                      Text(
                        '500 Stars Remaining',
                        style: h2,
                      ),
                    ],
                  ),
                  sh8,
                  CustomButton(
                    text: 'Buy more stars',
                    onPressed: () {
                      Get.to(()=> BuyStarView());
                    },
                  ),
                  sh8,
                  Center(
                    child: Text(
                      'Or',
                      style: h3.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  sh8,
                  CustomButton(
                    text: 'Cash Out Your Stars',
                    onPressed: () {
                      Get.to(()=> CashOutYourStarsView());
                    },
                    borderColor: AppColors.black,
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            sh20,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Received Stars',
                    onPressed: () {
                      setState(() {
                        showReceivedStars = true;
                      });
                    },
                    backgroundColor:
                        showReceivedStars ? Colors.black : Colors.transparent,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: showReceivedStars ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: 'Given Stars',
                    onPressed: () {
                      setState(() {
                        showReceivedStars = false;
                      });
                    },
                    backgroundColor:
                        showReceivedStars ? Colors.transparent : Colors.black,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: showReceivedStars ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            sh16,
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 24,
                top: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: AppColors.secondaryOrangeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#Sl',
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Full Name',
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Number of stars',
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Date',
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: AppColors.white,
                ),
                child: ListView.builder(
                  itemCount: dummyData.length,
                  itemBuilder: (context, index) {
                    final data = dummyData[index];
                    return ListTile(
                      leading: Text(
                        '${data['id']}',
                        style: h7,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data['fullName'],
                            style: h6,
                          ),
                          //sw20,
                          Text(
                            '⭐ ${data['numberOfStars']} Stars',
                            style: h6,
                          ),
                        ],
                      ),
                      //subtitle: Text('⭐ ${data['numberOfStars']} Stars'),
                      trailing: Text(
                        data['date'],
                        style: h7,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
