import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/district/district.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class DistrictCardWidget extends StatelessWidget {
  const DistrictCardWidget({super.key, required this.district});
  final District district;

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
                district.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              district.state.name.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${district.state.name.toUpperCase()})',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: themeData.offWhite),
                    ),
                  )
                  : Container(),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: district.createdBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(district.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: district.updatedBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(district.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
