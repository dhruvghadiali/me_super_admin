import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/academic_class/academic_class.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class AcademicClassCardWidget extends StatelessWidget {
  const AcademicClassCardWidget({super.key, required this.academicClass});
  final AcademicClass academicClass;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

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
                academicClass.academicClass.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: academicClass.createdBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(academicClass.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: academicClass.updatedBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(academicClass.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
