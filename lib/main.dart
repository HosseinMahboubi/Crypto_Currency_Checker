import 'package:currency/controllers/crypto_controller.dart';
import 'package:currency/controllers/time_controller.dart';
import 'package:currency/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX
  Get.put(AppSettingsProvider());
  Get.put(TimeController());
  // Initialize CryptoController to fetch data on app start
  Get.put(CryptoController());

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettingsProvider(),
      child: const MyApp(),
    ),
  );
}
