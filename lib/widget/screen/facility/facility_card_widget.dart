import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/facility/facility.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class FacilityCardWidget extends StatelessWidget {
  const FacilityCardWidget({super.key, required this.facility});
  final Facility facility;

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
                facility.facilityName.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              facility.facilityType.facilityType.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${facility.facilityType.facilityType.toUpperCase()})',
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
                audioUserInfo: facility.createdBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(facility.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: facility.updatedBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(facility.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
