import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class TabHeaderWidget extends StatelessWidget {
  const TabHeaderWidget({
    super.key,
    required this.activeTab,
    required this.icon,
  });

  final bool activeTab;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5,
            color:
                activeTab
                    ? themeData.calPolyPomonaGreen as Color
                    : themeData.offWhite as Color,
          ),
        ),
      ),
      child: Icon(
        icon,
        size: 30,
        color: activeTab ? themeData.offWhite : themeData.eerieBlack,
      ),
    );
  }
}
