import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      // App title
      'appTitle': 'Crypto Rates',

      // Info card
      'freeRateTitle': 'What are cryptocurrency rates?',
      'freeRateDescription':
          'Cryptocurrency rates show the current market value of digital assets. These values fluctuate based on global trading activity across various exchanges and reflect the real-time price of each cryptocurrency.',

      // Currency table
      'currencyTableTitle': 'Cryptocurrency Rate Table',
      'currencyName': 'Crypto Name',
      'price': 'Price',
      'change': 'Change',

      // Bottom container
      'update': 'Update',
      'lastUpdate': 'Last update',
      'updateSuccess': 'Update completed successfully.',

      // Drawer menu
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'language': 'Language',
      'english': 'English',
      'farsi': 'Farsi',
    },
    'fa': {
      // App title
      'appTitle': 'قیمت به روز ارزهای دیجیتال',

      // Info card
      'freeRateTitle': 'ارز دیجیتال چیست؟',
      'freeRateDescription':
          'نرخ ارزهای دیجیتال نشان دهنده ارزش بازار فعلی دارایی های دیجیتال است. این مقادیر بر اساس فعالیت معاملاتی جهانی در صرافی های مختلف تغییر می کنند و قیمت لحظه ای هر ارز دیجیتال را نشان می دهند.',

      // Currency table
      'currencyTableTitle': 'جدول نرخ ارزهای دیجیتال',
      'currencyName': 'نام ارز دیجیتال',
      'price': 'قیمت',
      'change': 'تغییر',

      // Bottom container
      'update': 'بروزرسانی',
      'lastUpdate': 'آخرین بروزرسانی',
      'updateSuccess': 'بروزرسانی با موفقیت انجام شد.',

      // Drawer menu
      'settings': 'تنظیمات',
      'darkMode': 'حالت تاریک',
      'language': 'زبان',
      'english': 'انگلیسی',
      'farsi': 'فارسی',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;

  // Info card
  String get freeRateTitle =>
      _localizedValues[locale.languageCode]!['freeRateTitle']!;
  String get freeRateDescription =>
      _localizedValues[locale.languageCode]!['freeRateDescription']!;

  // Currency table
  String get currencyTableTitle =>
      _localizedValues[locale.languageCode]!['currencyTableTitle']!;
  String get currencyName =>
      _localizedValues[locale.languageCode]!['currencyName']!;
  String get price => _localizedValues[locale.languageCode]!['price']!;
  String get change => _localizedValues[locale.languageCode]!['change']!;

  // Bottom container
  String get update => _localizedValues[locale.languageCode]!['update']!;
  String get lastUpdate =>
      _localizedValues[locale.languageCode]!['lastUpdate']!;
  String get updateSuccess =>
      _localizedValues[locale.languageCode]!['updateSuccess']!;

  // Drawer menu
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get farsi => _localizedValues[locale.languageCode]!['farsi']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
