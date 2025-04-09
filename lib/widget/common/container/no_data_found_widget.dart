import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_rounded,
            color: themeData.metallicRed,
            size: 80,
          ),
          Text(
            appLocalizations.noDataFoundTitleMessage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              appLocalizations.noDataFoundSubtitleMessage,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        ],
      ),
    );
  }
}