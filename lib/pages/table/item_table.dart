import 'package:currency/controllers/crypto_controller.dart';
import 'package:currency/providers/app_settings_provider.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ItemTable extends StatelessWidget {
  ItemTable({
    super.key,
  });

  // Get the crypto controller
  final CryptoController _cryptoController = Get.put(CryptoController());

  @override
  Widget build(BuildContext context) {
    // Get the app settings provider from context instead of Get.find
    final appSettings = Provider.of<AppSettingsProvider>(context);

    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.borderRadius,
        color: Colors.transparent,
      ),
      child: Obx(
        () {
          // Show loading indicator while fetching data
          if (_cryptoController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show error message if there's an error
          if (_cryptoController.error.value.isNotEmpty) {
            return Center(
              child: Text(
                _cryptoController.error.value,
                style: TextStyle(color: AppTheme.error),
                textAlign: TextAlign.center,
              ),
            );
          }

          // Show empty message if there's no data
          if (_cryptoController.cryptocurrencies.isEmpty) {
            return const Center(
              child: Text('No cryptocurrency data available'),
            );
          }

          // Show the list of cryptocurrencies
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _cryptoController.cryptocurrencies.length,
            itemBuilder: (BuildContext context, int index) {
              final currency = _cryptoController.cryptocurrencies[index];
              final isUp = currency.status == 'up';
              final isDown = currency.status == 'down';
              final Color changeColor = isUp
                  ? AppTheme.success
                  : isDown
                      ? AppTheme.error
                      : Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: [AppTheme.cardShadow],
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppTheme.borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Currency name
                        Flexible(
                          flex: 2,
                          child: Text(
                            currency.title!,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Price with appropriate currency based on language
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              currency.getPrice(appSettings.isEnglish),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        // Change indicator
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: changeColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isUp)
                                  const Icon(Icons.arrow_upward,
                                      color: AppTheme.success, size: 16),
                                if (isDown)
                                  const Icon(Icons.arrow_downward,
                                      color: AppTheme.error, size: 16),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    currency.changes!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: changeColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
