// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/profile/controllers/subscription_plan_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_text_style/styles.dart';
//
// class PaymentView extends StatefulWidget {
//   final String? paymentUrl;
//
//   const PaymentView({super.key, this.paymentUrl});
//
//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }
//
// class _PaymentViewState extends State<PaymentView> {
//   WebViewController? _controller;
//   final SubscriptionPlanController subscriptionPlanController = Get.put(SubscriptionPlanController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text("Payment", style: titleStyle),
//         centerTitle: true,
//       ),
//       body: WebView(
//         initialUrl: widget.paymentUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//         onPageStarted: (String url) {
//           debugPrint('Page start loading: $url');
//         },
//         onPageFinished: (String url) {
//           debugPrint('Page finished loading: $url');
//           if (url.contains("verify-session-for")) {
//             subscriptionPlanController.paymentResults(paymentLink: url);
//             debugPrint('::::::::::::: if condition ::::::::::::::::');
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../controllers/subscription_plan_controller.dart';

class PaymentView extends StatefulWidget {
  final String? paymentUrl;

  const PaymentView({super.key, this.paymentUrl});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late final WebViewController _controller;
  final SubscriptionPlanController subscriptionPlanController = Get.put(SubscriptionPlanController());

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page start loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            if (url.contains("verify-session-for")) {
              subscriptionPlanController.paymentResults(paymentLink: url);
              debugPrint('::::::::::::: if condition ::::::::::::::::');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment'.tr, style: titleStyle), // Updated to use translation
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}