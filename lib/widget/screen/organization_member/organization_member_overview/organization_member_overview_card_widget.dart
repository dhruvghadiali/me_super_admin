import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_member_overview/organization_member_overview_widget.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_member_overview/organization_member_overview_card_header_widget.dart';

class OrganizationMemberOverviewCardWidget extends StatelessWidget {
  const OrganizationMemberOverviewCardWidget({super.key, required this.isNewRecord});

  final bool isNewRecord;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return GetBuilder<OrganizationMemberController>(
      builder: (organizationMemberControllerContext) {
        return Column(
          children:
              organizationMemberControllerContext.organizationMembers.asMap().entries.map((entry) {
                return Card(
                  color: themeData.eerieBlack,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: OrganizationMemberOverviewCardHeaderWidget(index: entry.key + 1, isNewRecord: isNewRecord),
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        children: [
                          Divider(color: themeData.offWhite, endIndent: 15, indent: 15),
                          OrganizationMemberOverviewWidget(organizationMember: entry.value),
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
