import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

/*
 * Widget: NewSchoolFormSummaryTabCardTextWidget
 * ---------------------------------------------
 * Displays a title and value in a column, styled for summary cards in the new school form summary UI.
 * Used for showing labeled data (e.g., address, admin name) in summary sections.
 *
 * Props:
 *   - title: The label/title to display (String)
 *   - value: The value/content to display (String)
 */
class NewSchoolFormSummaryTabCardTextWidget extends StatelessWidget {
  const NewSchoolFormSummaryTabCardTextWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the widget UI.
     * - Uses the theme for consistent styling.
     * - Displays the title in bold and the value below it.
     */
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, maxLines: 1, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeData.offWhite)),
        SizedBox(height: 15),
      ],
    );
  }
}
