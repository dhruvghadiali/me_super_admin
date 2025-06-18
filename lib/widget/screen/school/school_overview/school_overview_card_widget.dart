import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/school/school_overview/school_overview_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_overview/school_overview_card_header_widget.dart';

class SchoolOverviewCardWidget extends StatelessWidget {
  const SchoolOverviewCardWidget({super.key, required this.isNewRecord});

  final bool isNewRecord;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Card(
      color: themeData.eerieBlack,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: SchoolOverviewCardHeaderWidget(isNewRecord: isNewRecord)),
            Divider(color: themeData.offWhite, endIndent: 15, indent: 15),
            SchoolOverviewWidget(),
          ],
        ),
      ),
    );
  }
}
