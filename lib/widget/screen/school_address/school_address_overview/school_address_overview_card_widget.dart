import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/widget/screen/school_admin/school_admin_overview/school_admin_overview_card_widget.dart';
import 'package:me_super_admin/widget/screen/school_address/school_address_overview/school_address_overview_widget.dart';
import 'package:me_super_admin/widget/screen/school_admin/school_admin_overview/school_admin_overview_card_header_widget.dart';
import 'package:me_super_admin/widget/screen/school_address/school_address_overview/school_address_overview_card_header_widget.dart';

class SchoolAddressOverviewCardWidget extends StatelessWidget {
  const SchoolAddressOverviewCardWidget({super.key, required this.isNewRecord});

  final bool isNewRecord;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return GetBuilder<SchoolAddressController>(
      builder: (schoolAddressControllerContext) {
        return Column(
          children:
              schoolAddressControllerContext.schoolAddresses.asMap().entries.map((entry) {
                return Card(
                  color: themeData.eerieBlack,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: SchoolAddressOverviewCardHeaderWidget(index: entry.key + 1, isNewRecord: isNewRecord),
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        children: [
                          Divider(color: themeData.offWhite, endIndent: 15, indent: 15),
                          SchoolAddressOverviewWidget(schoolAddress: entry.value),
                          ExpansionTile(
                            title: SchoolAdminOverviewCardHeaderWidget(isNewRecord: isNewRecord),
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            children: [
                              Divider(color: themeData.offWhite, endIndent: 15, indent: 15),
                              GetBuilder<SchoolAdminController>(
                                builder: (schoolAdminControllerContext) {
                                  return SchoolAdminOverviewCardWidget(
                                    isNewRecord: false,
                                    schoolAdmin: schoolAdminControllerContext.schoolAdmins.firstWhere((schoolAdmin) => schoolAdmin.id == entry.value.userId),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}
