import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'common/helper/socket_service.dart';

void main() async {
  // Ensure the widget binding is initialized for async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize SocketService with a placeholder onNewMessage callback
  final socketService = SocketService(
    onNewMessage: (message) {
      // Placeholder: This will be overridden by ChatsController
      print('New message received (placeholder): $message');
    },
  );
  await socketService.initialize();
  Get.put(socketService, permanent: true);

  runApp(
    GetMaterialApp(
      title: "Tails Date",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}