import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class AreaNameCardWidget extends StatelessWidget {
  const AreaNameCardWidget({super.key, required this.areaName});
  final AreaName areaName;

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
                areaName.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              areaName.city.name.isNotEmpty && areaName.city.district.name.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${areaName.city.name.toUpperCase()} - ${areaName.city.district.name.toUpperCase()})',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: themeData.offWhite),
                    ),
                  )
                  : Container(),
              areaName.city.district.state.name.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${areaName.city.district.state.name.toUpperCase()})',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                    ),
                  )
                  : Container(),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: areaName.createdBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(areaName.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: areaName.updatedBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(areaName.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
