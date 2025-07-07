import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key, required this.message, required this.onPressed});

  final String message;
  final Function onPressed;

  void onButtonPressed() {
    HapticFeedback.heavyImpact();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return AlertDialog(
      backgroundColor: themeData.offWhite,
      title: Column(
        children: [
          Icon(Icons.info_outline_rounded, size: 50, color: themeData.harvestGold),
          const SizedBox(height: 10),
          Text(
            'Alert Message',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: themeData.harvestGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        message,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          child: Text(appLocalizations.okButtonText, style: Theme.of(context).textTheme.labelLarge),
          onPressed: () => onButtonPressed(),
        ),
      ],
    );
  }
}
