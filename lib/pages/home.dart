import 'package:currency/localization/app_localizations.dart';
import 'package:currency/pages/table/item_table.dart';
import 'package:currency/pages/table/table_names.dart';
import 'package:currency/theme/app_theme.dart';
import 'package:currency/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import 'bottom_time_button_container.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/gold_appbar.png"),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppTheme.borderRadius,
                  boxShadow: [AppTheme.cardShadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              "assets/images/question_mark.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            AppLocalizations.of(context).freeRateTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        AppLocalizations.of(context).freeRateDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Currency table section
              Text(
                AppLocalizations.of(context).currencyTableTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 12.0),
              const TableNames(),
              const SizedBox(height: 12.0),
              ItemTable(),
              const SizedBox(height: 24.0),
              BottomTimeButtonContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
