import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ApiRequestLoaderWidget extends StatelessWidget {
  const ApiRequestLoaderWidget({super.key, required this.appColorScheme});

  final AppColorScheme appColorScheme;

  Color? setLoaderColor({
    required BuildContext context,
    required AppColorScheme appColorScheme,
  }) {
    switch (appColorScheme) {
      case AppColorScheme.primary:
        return Theme.of(context).colorScheme.primary;
      case AppColorScheme.secondary:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: themeData.eerieBlack,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            color: setLoaderColor(
              context: context,
              appColorScheme: appColorScheme,
            ),
            padding: const EdgeInsets.all(10),
            child: CircularProgressIndicator(color: themeData.offWhite),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeData.offWhite,
                border: Border.all(
                  color:
                      setLoaderColor(
                            context: context,
                            appColorScheme: appColorScheme,
                          )
                          as Color,
                  width: 1,
                ),
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.apiRequestProcessingTitle,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    appLocalizations.apiRequestProcessingMessage,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
