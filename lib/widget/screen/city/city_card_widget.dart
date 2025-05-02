import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';

class CityCardWidget extends StatelessWidget {
  const CityCardWidget({super.key, required this.city});
  final City city;

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
                city.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: themeData.offWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  '(${city.district.name.toUpperCase()} - ${city.district.state.name.toUpperCase()})',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: city.createdBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(city.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: city.updatedBy,
                auditDateTimeInfo: DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(city.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
