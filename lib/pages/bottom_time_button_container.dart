import 'package:currency/controllers/crypto_controller.dart';
import 'package:currency/controllers/time_controller.dart';
import 'package:currency/localization/app_localizations.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTimeButtonContainer extends StatelessWidget {
  BottomTimeButtonContainer({
    super.key,
  });

  // Get the time controller
  final TimeController _timeController = Get.find<TimeController>();

  // Get the crypto controller
  final CryptoController _cryptoController = Get.find<CryptoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppTheme.borderRadius,
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Update button
            ElevatedButton.icon(
              onPressed: () {
                _timeController.updateTime();
                _cryptoController.fetchCryptocurrencies();
                _showSnackBar(
                    context, AppLocalizations.of(context).updateSuccess);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppLocalizations.of(context).update),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),

            // Last update time
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 18,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Obx(
                    () => Text(
                      "${AppLocalizations.of(context).lastUpdate} ${_timeController.lastUpdateTime.value ?? ''}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: AppTheme.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadius),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );
}
