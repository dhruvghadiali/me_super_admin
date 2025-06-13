import 'package:flutter/material.dart';
import 'package:me_super_admin/model/school_admin/school_admin.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/school_admin/school_admin_overview/school_admin_overview_widget.dart';

class SchoolAdminOverviewCardWidget extends StatelessWidget {
  const SchoolAdminOverviewCardWidget({super.key, required this.isNewRecord, required this.schoolAdmin});

  final bool isNewRecord;
  final SchoolAdmin schoolAdmin;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Card(
      color: themeData.eerieBlack,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SchoolAdminOverviewWidget(schoolAdmin: schoolAdmin)]),
      ),
    );
  }
}
