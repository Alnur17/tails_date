import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Services/socket_services.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // Ensure the widget binding is initialized for async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  final SocketService socketService = Get.put(SocketService());
  await socketService.init();

  runApp(
    GetMaterialApp(
      title: "Tails Date",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}