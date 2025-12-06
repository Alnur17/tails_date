// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/views/buy_star_view.dart';
// import 'package:tails_date/app/modules/profile/views/cash_out_your_stars_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/widgets/custom_button.dart';
//
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
//
// class StarBalanceView extends StatefulWidget {
//   final int starBalance;
//   const StarBalanceView({super.key, required this.starBalance});
//
//   @override
//   State<StarBalanceView> createState() => _StarBalanceViewState();
// }
//
// class _StarBalanceViewState extends State<StarBalanceView> {
//   bool showReceivedStars = true;
//
//   final List<Map<String, dynamic>> dummyData = List.generate(
//     10,
//     (index) => {
//       'id': index + 1,
//       'fullName': '@Happy_Paws',
//       'numberOfStars': 10,
//       'date': '02 Dec, 2024',
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Star Balance'),
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
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'My Current Star Balance',
//               style: h3.copyWith(fontWeight: FontWeight.w700),
//             ),
//             sh12,
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.black),
//                 borderRadius: BorderRadius.circular(16),
//                 color: AppColors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Track and manage stars here',
//                     style:
//                         h4.copyWith(fontSize: 18, color: AppColors.brownColor),
//                   ),
//                   sh8,
//                   Row(
//                     children: [
//                       Text('🌟'),
//                       sw8,
//                       Text(
//                         '${widget.starBalance} Stars Remaining',
//                         style: h2,
//                       ),
//                     ],
//                   ),
//                   sh8,
//                   CustomButton(
//                     text: 'Buy more stars',
//                     onPressed: () {
//                       Get.to(()=> BuyStarView());
//                     },
//                   ),
//                   sh8,
//                   Center(
//                     child: Text(
//                       'Or',
//                       style: h3.copyWith(fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   sh8,
//                   CustomButton(
//                     text: 'Cash Out Your Stars',
//                     onPressed: () {
//                       Get.to(()=> CashOutYourStarsView(starBalance: widget.starBalance));
//                     },
//                     borderColor: AppColors.black,
//                     backgroundColor: AppColors.white,
//                     textStyle: h3.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             sh20,
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomButton(
//                     text: 'Received Stars',
//                     onPressed: () {
//                       setState(() {
//                         showReceivedStars = true;
//                       });
//                     },
//                     backgroundColor:
//                         showReceivedStars ? Colors.black : Colors.transparent,
//                     textStyle: h3.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: showReceivedStars ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomButton(
//                     text: 'Given Stars',
//                     onPressed: () {
//                       setState(() {
//                         showReceivedStars = false;
//                       });
//                     },
//                     backgroundColor:
//                         showReceivedStars ? Colors.transparent : Colors.black,
//                     textStyle: h3.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: showReceivedStars ? Colors.black : Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             sh16,
//             Container(
//               padding: EdgeInsets.only(
//                 left: 12,
//                 right: 24,
//                 top: 12,
//                 bottom: 12,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//                 color: AppColors.secondaryOrangeColor,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '#Sl',
//                     style: h6.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     ),
//                   ),
//                   Text(
//                     'Full Name',
//                     style: h6.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     ),
//                   ),
//                   Text(
//                     'Number of stars',
//                     style: h6.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     ),
//                   ),
//                   Text(
//                     'Date',
//                     style: h6.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                   color: AppColors.white,
//                 ),
//                 child: ListView.builder(
//                   itemCount: dummyData.length,
//                   itemBuilder: (context, index) {
//                     final data = dummyData[index];
//                     return ListTile(
//                       leading: Text(
//                         '${data['id']}',
//                         style: h7,
//                       ),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data['fullName'],
//                             style: h6,
//                           ),
//                           //sw20,
//                           Text(
//                             '⭐ ${data['numberOfStars']} Stars',
//                             style: h6,
//                           ),
//                         ],
//                       ),
//                       //subtitle: Text('⭐ ${data['numberOfStars']} Stars'),
//                       trailing: Text(
//                         data['date'],
//                         style: h7,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/profile/views/buy_star_view.dart';
import 'package:tails_date/app/modules/profile/views/cash_out_your_stars_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/send_and_received_stars_controller.dart';

class StarBalanceView extends StatefulWidget {
  final int starBalance;
  const StarBalanceView({super.key, required this.starBalance});

  @override
  State<StarBalanceView> createState() => _StarBalanceViewState();
}

class _StarBalanceViewState extends State<StarBalanceView> {
  final SendAndReceivedStarsController controller = Get.put(SendAndReceivedStarsController());
  bool showReceivedStars = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Star_Balance'.tr), // Updated to use translation
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
              'My_Current_Star_Balance'.tr, // Updated to use translation
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
                    'Track_And_Manage_Stars'.tr, // Updated to use translation
                    style: h4.copyWith(fontSize: 18, color: AppColors.brownColor),
                  ),
                  sh8,
                  Row(
                    children: [
                      Text('🌟'),
                      sw8,
                      Expanded(
                        child: Text(
                          '${widget.starBalance} ${'Stars_Remaining'.tr}', // Updated to use translation
                          style: h2,
                        ),
                      ),
                    ],
                  ),
                  sh8,
                  CustomButton(
                    text: 'Buy_More_Stars'.tr, // Updated to use translation
                    onPressed: () {
                      Get.to(() => BuyStarView());
                    },
                  ),
                  sh8,
                  Center(
                    child: Text(
                      'OrS'.tr, // Updated to use translation
                      style: h3.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  sh8,
                  CustomButton(
                    text: 'Cash_Out_Your_Stars'.tr, // Updated to use translation
                    onPressed: () {
                      Get.to(() => CashOutYourStarsView(starBalance: widget.starBalance));
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
                    text: 'Received_Stars'.tr, // Updated to use translation
                    onPressed: () {
                      setState(() {
                        showReceivedStars = true;
                      });
                    },
                    backgroundColor: showReceivedStars ? Colors.black : Colors.transparent,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: showReceivedStars ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: 'Given_Stars'.tr, // Updated to use translation
                    onPressed: () {
                      setState(() {
                        showReceivedStars = false;
                      });
                    },
                    backgroundColor: showReceivedStars ? Colors.transparent : Colors.black,
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
                    'Table_Header_Sl'.tr, // Updated to use translation
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Table_Header_Full_Name'.tr, // Updated to use translation
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Table_Header_Number_Of_Stars'.tr, // Updated to use translation
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Table_Header_Date'.tr, // Updated to use translation
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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value, style: h6));
                  }
                  final data = showReceivedStars ? controller.receivedStars : controller.sentStars;
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        showReceivedStars ? 'No_Stars_Received_Yet'.tr : 'No_Stars_Sent_Yet'.tr, // Updated to use translation
                        style: h6,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final star = data[index];
                      final name = showReceivedStars ? star.sender?.name : star.receiver?.name;
                      final date = star.createdAt?.toString().substring(0, 10) ?? '';
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: h7,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name ?? '@Unknown',
                              style: h6,
                            ),
                            Text(
                              '⭐ ${star.amount} ${'Stars_Suffix'.tr}', // Updated to use translation
                              style: h6,
                            ),
                          ],
                        ),
                        trailing: Text(
                          date,
                          style: h7,
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}