import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class TabContainerWidget extends StatelessWidget {
  const TabContainerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return Container(
      decoration: BoxDecoration(
        color: themeData.offWhite,
        boxShadow: [
          BoxShadow(
            color: themeData.eerieBlack as Color,
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
