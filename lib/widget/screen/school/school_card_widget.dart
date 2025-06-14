import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/school/school.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/container/audit_trail_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_information/school_information_widget.dart';

class SchoolCardWidget extends StatelessWidget {
  const SchoolCardWidget({super.key, required this.school, required this.isActiveData});
  final School school;
  final bool isActiveData;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Card(
      elevation: 2,
      color: themeData.eerieBlack,
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: isActiveData ? themeData.calPolyPomonaGreen as Color : themeData.metallicRed as Color, width: 4)),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${school.name.toUpperCase()} (${school.shortName.toUpperCase()})',
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold),
              ),
              Divider(color: themeData.offWhite, thickness: 0.4),
              SchoolInformationWidget(title: 'Affiliation Number', description: school.affiliateNumber.toUpperCase()),
              SchoolInformationWidget(title: 'Email', description: school.email.toUpperCase()),
              SchoolInformationWidget(title: 'Phone Number', description: school.phoneNumber.toUpperCase()),
              SchoolInformationWidget(title: 'Established Year', description: school.establishedYear.toString()),
              Divider(color: themeData.offWhite, thickness: 0.4),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Created At:',
                audioInfoLabel: 'Created By:',
                audioUserInfo: school.createdBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(school.createdAt),
              ),
              AuditTrailWidget(
                audioDateTimeInfoLabel: 'Updated At:',
                audioInfoLabel: 'Updated By:',
                audioUserInfo: school.updatedBy,
                auditDateTimeInfo: DateFormat('dd MMM yyyy hh:mm a').format(school.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
