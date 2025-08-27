import 'package:currency/localization/app_localizations.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TableNames extends StatelessWidget {
  const TableNames({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.borderRadius,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).currencyName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              AppLocalizations.of(context).price,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              AppLocalizations.of(context).change,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
