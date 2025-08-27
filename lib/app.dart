import 'package:currency/localization/app_localizations.dart';
import 'package:currency/pages/home.dart';
import 'package:currency/providers/app_settings_provider.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(isEnglish: appSettings.isEnglish),
      darkTheme: AppTheme.getDarkTheme(isEnglish: appSettings.isEnglish),
      themeMode: appSettings.themeMode,
      locale: appSettings.locale,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''),
        Locale('en', ''),
      ],
      home: const Home(),
    );
  }
}
