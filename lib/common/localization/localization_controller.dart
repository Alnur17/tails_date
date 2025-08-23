import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  // Observable for selected language
  var selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  static const Map<String, String> languageMap = {
    'en': 'English',
    'fr': 'French',
    'es': 'Spanish',
    'de': 'German', // Added German
  };

  // Load saved language from SharedPreferences
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language') ?? 'English';
    selectedLanguage.value = savedLanguage;
    _updateLocale(savedLanguage);
  }

  // Change language and save it
  Future<void> changeLanguage(String language) async {
    selectedLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    _updateLocale(language);
  }

  // Update GetX locale
  void _updateLocale(String language) {
    Locale locale;
    switch (language) {
      case 'French':
        locale = const Locale('fr', 'FR');
        break;
      case 'Spanish':
        locale = const Locale('es', 'ES');
        break;
      case 'German':
        locale = const Locale('de', 'DE');
        break;
      default:
        locale = const Locale('en', 'US');
    }
    Get.updateLocale(locale);
  }

  // ✅ Get current locale
  Locale getCurrentLocale() {
    switch (selectedLanguage.value) {
      case 'French':
        return const Locale('fr', 'FR');
      case 'Spanish':
        return const Locale('es', 'ES');
      case 'German':
        return const Locale('de', 'DE');
      default:
        return const Locale('en', 'US');
    }
  }
}
