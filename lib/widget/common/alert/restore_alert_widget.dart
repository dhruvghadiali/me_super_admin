import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class RestoreAlertWidget extends StatelessWidget {
  const RestoreAlertWidget({
    super.key,
    required this.onRestore,
  });

  final Function onRestore;

  void onCancelPressed(BuildContext context) {
    HapticFeedback.heavyImpact();
    Navigator.of(context).pop();
  }

  void onRestorePressed() {
    HapticFeedback.heavyImpact();
    onRestore();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return AlertDialog(
      backgroundColor: themeData.offWhite,
      title: Column(
        children: [
          Icon(
            Icons.warning,
            size: 50,
            color: themeData.calPolyPomonaGreen,
          ),
          const SizedBox(height: 10),
          Text(
            appLocalizations.deleteAlertTitle,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.calPolyPomonaGreen,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      content: Text(
        appLocalizations.restoreAlertSubtitle,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          child: Text(
            appLocalizations.cancelButtonText,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () => onCancelPressed(context),
        ),
        TextButton(
          child: Text(
            appLocalizations.restoreButtonText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: themeData.calPolyPomonaGreen,
                ),
          ),
          onPressed: () => onRestorePressed(),
        ),
      ],
    );
  }
}
