import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
    required this.appColorScheme,
  });

  final AppColorScheme appColorScheme;

  Color? setLoaderColor({
    required BuildContext context,
    required AppColorScheme loaderColorStatus,
  }) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    switch (loaderColorStatus) {
      case AppColorScheme.primary:
        return themeData.eerieBlack;
      case AppColorScheme.secondary:
        return themeData.calPolyPomonaGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: setLoaderColor(
          context: context,
          loaderColorStatus: appColorScheme,
        ),
      ),
    );
  }
}
