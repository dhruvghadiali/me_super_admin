import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/education_board/education_board.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class EducationBoardCardWidget extends StatelessWidget {
  const EducationBoardCardWidget({super.key, required this.educationBoard});
  final EducationBoard educationBoard;

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
                educationBoard.educationBoard.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioUserInfo: "Created By:  ${educationBoard.createdBy}",
                auditDateTimeInfo:
                    "Created At:  ${DateFormat('dd MMM yyyy hh:mm a').format(educationBoard.createdAt)}",
              ),
              AuditTrailWidget(
                audioUserInfo: "Updated By:  ${educationBoard.updatedBy}",
                auditDateTimeInfo:
                    "Updated At:  ${DateFormat('dd MMM yyyy hh:mm a').format(educationBoard.updatedAt)}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
