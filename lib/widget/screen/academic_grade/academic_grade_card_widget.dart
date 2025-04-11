import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/academic_grade/academic_grade.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class AcademicGradeCardWidget extends StatelessWidget {
  const AcademicGradeCardWidget({super.key, required this.academicGrade});
  final AcademicGrade academicGrade;

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
                academicGrade.academicGrade.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioUserInfo: "Created By:  ${academicGrade.createdBy}",
                auditDateTimeInfo:
                    "Created At:  ${DateFormat('dd MMM yyyy hh:mm a').format(academicGrade.createdAt)}",
              ),
              AuditTrailWidget(
                audioUserInfo: "Updated By:  ${academicGrade.updatedBy}",
                auditDateTimeInfo:
                    "Updated At:  ${DateFormat('dd MMM yyyy hh:mm a').format(academicGrade.updatedAt)}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
