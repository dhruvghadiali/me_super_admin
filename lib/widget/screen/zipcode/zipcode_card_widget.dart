import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class ZipcodeCardWidget extends StatelessWidget {
  const ZipcodeCardWidget({super.key, required this.zipcode});
  final Zipcode zipcode;

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
                zipcode.zipcode.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              zipcode.areaName.name.isNotEmpty && zipcode.areaName.city.name.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${zipcode.areaName.name.toUpperCase()} - ${zipcode.areaName.city.name.toUpperCase()})',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: themeData.offWhite),
                    ),
                  )
                  : Container(),
              zipcode.areaName.city.district.name.isNotEmpty &&
                      zipcode.areaName.city.district.state.name.isNotEmpty
                  ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(${zipcode.areaName.city.district.name.toUpperCase()} - ${zipcode.areaName.city.district.state.name})',
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
                audioUserInfo: zipcode.createdBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(zipcode.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: zipcode.updatedBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(zipcode.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
