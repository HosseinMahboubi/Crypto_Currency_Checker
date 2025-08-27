import 'package:currency/providers/app_settings_provider.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    final isEnglish = appSettings.isEnglish;
    final isDarkMode = appSettings.isDarkMode;
    
    // Use the appropriate font family based on language
    final String fontFamily = isEnglish ? 'inter' : 'dana';
    
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App logo and name
                Row(
                  children: [
                    Image.asset(
                      "assets/images/gold_appbar.png",
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      isEnglish ? "Currency Rates" : "قیمت به روز ارزها",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Settings title
                Text(
                  isEnglish ? "Settings" : "تنظیمات",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Dark mode toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppTheme.borderRadius,
                    boxShadow: [AppTheme.cardShadow],
                  ),
                  child: ListTile(
                    title: Text(
                      isEnglish ? "Dark Mode" : "حالت تاریک",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        appSettings.toggleThemeMode();
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Language toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppTheme.borderRadius,
                    boxShadow: [AppTheme.cardShadow],
                  ),
                  child: ListTile(
                    title: Text(
                      isEnglish ? "Language" : "زبان",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      isEnglish ? "English" : "فارسی",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.translate,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        appSettings.toggleLanguage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}