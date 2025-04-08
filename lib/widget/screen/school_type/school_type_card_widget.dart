import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class SchoolTypeCardWidget extends StatelessWidget {
  const SchoolTypeCardWidget({super.key, required this.schoolType});
  final SchoolType schoolType;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Card(
      elevation: 2,
      color: themeData.eerieBlack,
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                schoolType.schoolType.toUpperCase(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: themeData.offWhite),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              Text(
                "Created At:  ${DateFormat('dd MMM yyyy').format(schoolType.createdAt)}",
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
