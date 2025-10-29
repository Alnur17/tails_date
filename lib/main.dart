import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Services/socket_services.dart';
import 'app/routes/app_pages.dart';
import 'common/app_constant/app_constant.dart';
import 'common/helper/local_store.dart';
import 'common/helper/notification_services.dart';
import 'common/localization/app_translations.dart';
import 'common/localization/localization_controller.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure the widget binding is initialized for async operations
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize LocalizationController before GetMaterialApp
  final localizationController = Get.put(LocalizationController());

  // Wait for saved language to load
  await localizationController.loadSavedLanguage();

  // Initialize SocketService
  final SocketService socketService = Get.put(SocketService());
  await socketService.init();

  final NotificationServices notificationServices = NotificationServices();

  notificationServices.requestNotificationPermission();

  notificationServices.getDeviceToken().then(
        (value) {
      debugPrint('=============== > Device Token: $value < ==================');
      LocalStorage.saveData(key: AppConstant.fcmToken, data: value);

      String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);

      debugPrint('=========>fcm Token from local storage: $fcmToken <========');
    },
  );

  // Set up the background message handler after initialization
  FirebaseMessaging.onBackgroundMessage(notificationServices.firebaseMessagingBackgroundHandler);

  // Configure local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await notificationServices.flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
      }
    },
  );

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message received: ${message.notification?.title}');
    notificationServices.showNotification(
      message.notification?.title,
      message.notification?.body,
    );
  });

  runApp(
    GetMaterialApp(
      title: "Tails Date",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translations: AppTranslations(),
      locale: localizationController.getCurrentLocale(),
      fallbackLocale: const Locale('en', 'US'),
    ),
  );
}