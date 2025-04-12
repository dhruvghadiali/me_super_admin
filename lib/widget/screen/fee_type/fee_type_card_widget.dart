import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/fee_type/fee_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class FeeTypeCardWidget extends StatelessWidget {
  const FeeTypeCardWidget({super.key, required this.feeType});
  final FeeType feeType;

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
                feeType.feeType.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioUserInfo: "Created By:  ${feeType.createdBy}",
                auditDateTimeInfo:
                    "Created At:  ${DateFormat('dd MMM yyyy hh:mm a').format(feeType.createdAt)}",
              ),
              AuditTrailWidget(
                audioUserInfo: "Updated By:  ${feeType.updatedBy}",
                auditDateTimeInfo:
                    "Updated At:  ${DateFormat('dd MMM yyyy hh:mm a').format(feeType.updatedAt)}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
