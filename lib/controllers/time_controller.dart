import 'package:currency/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeController extends GetxController {
  // Observable variable for the last update time
  final Rx<String?> lastUpdateTime = Rx<String?>(null);
  
  @override
  void onInit() {
    super.onInit();
    // Initialize with current time
    updateTime();
  }
  
  // Update the time
  void updateTime() {
    lastUpdateTime.value = getCurrentFormattedTime();
  }
  
  // Get the current formatted time based on language settings
  String getCurrentFormattedTime() {
    final now = DateTime.now();
    final appSettings = Get.find<AppSettingsProvider>();
    final isEnglish = appSettings.isEnglish;

    if (isEnglish) {
      // English format: HH:MM AM/PM
      return DateFormat('h:mm a').format(now);
    } else {
      // Persian format: HH:MM
      return DateFormat('HH:mm').format(now);
    }
  }
}