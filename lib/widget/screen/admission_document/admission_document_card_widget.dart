import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';
import 'package:me_super_admin/model/admission_document/admission_document.dart';

class AdmissionDocumentCardWidget extends StatelessWidget {
  const AdmissionDocumentCardWidget({super.key, required this.admissionDocument});
  final AdmissionDocument admissionDocument;

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
                admissionDocument.admissionDocument.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: admissionDocument.createdBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(admissionDocument.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: admissionDocument.updatedBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(admissionDocument.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
