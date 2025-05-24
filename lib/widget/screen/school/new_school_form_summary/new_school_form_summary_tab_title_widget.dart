import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

/*
 * Widget: NewSchoolFormSummaryTabTitleWidget
 * ------------------------------------------
 * Displays a tab title for the summary tab navigation.
 * Highlights the tab if it is active.
 *
 * Props:
 *   - title: The tab title to display (String)
 *   - isActive: Whether the tab is currently active (bool)
 */

class NewSchoolFormSummaryTabTitleWidget extends StatelessWidget {
  const NewSchoolFormSummaryTabTitleWidget({super.key, required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the tab title widget.
     * - Uses theme color to highlight the active tab.
     */
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: isActive ? themeData.offWhite : themeData.eerieBlack));
  }
}
