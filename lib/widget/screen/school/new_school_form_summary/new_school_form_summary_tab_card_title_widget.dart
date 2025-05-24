import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

/*
 * Widget: NewSchoolFormSummaryTabCardTitleWidget
 * ----------------------------------------------
 * Displays a bold title for a section in the new school form summary card.
 * Used to visually separate and label different summary sections.
 *
 * Props:
 *   - title: The section title to display (String)
 */

class NewSchoolFormSummaryTabCardTitleWidget extends StatelessWidget {
  const NewSchoolFormSummaryTabCardTitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the widget UI.
     * - Uses the theme for consistent styling.
     * - Displays the title in bold with a bottom margin.
     */
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(title, maxLines: 1, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold)),
    );
  }
}
