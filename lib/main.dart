import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Services/socket_services.dart';
import 'app/routes/app_pages.dart';
import 'common/localization/app_translations.dart';
import 'common/localization/localization_controller.dart';

void main() async {
  // Ensure the widget binding is initialized for async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize LocalizationController before GetMaterialApp
  Get.put(LocalizationController());

  // Initialize SocketService
  final SocketService socketService = Get.put(SocketService());
  await socketService.init();

  runApp(
    GetMaterialApp(
      title: "Tails Date",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translations: AppTranslations(), // Set translations
      locale: Get.find<LocalizationController>().getCurrentLocale(), // Set initial locale
      fallbackLocale: const Locale('en', 'US'), // Fallback to English if needed
    ),
  );
}