import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/school/edit_school_information_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/organization/organization_overview/organization_overview_card_widget.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_member_overview/organization_member_overview_card_widget.dart';
import 'package:me_super_admin/widget/screen/school/edit_school_information_header/edit_school_information_header_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_overview/school_overview_card_widget.dart';
import 'package:me_super_admin/widget/screen/school_address/school_address_overview/school_address_overview_card_widget.dart';

class EditSchoolInformationWidget extends StatefulWidget {
  const EditSchoolInformationWidget({super.key});

  @override
  State<EditSchoolInformationWidget> createState() => _EditSchoolInformationWidgetState();
}

class _EditSchoolInformationWidgetState extends State<EditSchoolInformationWidget> with SingleTickerProviderStateMixin {
  Widget setEditSchoolInformationCard(EditSchoolInformationHeader currentHeader) {
    switch (currentHeader) {
      case EditSchoolInformationHeader.organization:
        return OrganizationOverviewCardWidget(isNewRecord: false);
      case EditSchoolInformationHeader.organizationMembers:
        return OrganizationMemberOverviewCardWidget(isNewRecord: false);
      case EditSchoolInformationHeader.school:
        return SchoolOverviewCardWidget(isNewRecord: false);
      case EditSchoolInformationHeader.schoolAddress:
        return SchoolAddressOverviewCardWidget(isNewRecord: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return GetBuilder<EditSchoolInformationController>(
      builder: (editSchoolInformationControllerContext) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(top: 25, left: 5, right: 5, bottom: 40),
              child: Column(
                children: [
                  EditSchoolInformationHeaderWidget(currentHeader: editSchoolInformationControllerContext.currentHeader),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 25),
                      child: SingleChildScrollView(child: setEditSchoolInformationCard(editSchoolInformationControllerContext.currentHeader)),
                    ),
                  ),
                ],
              ),
            ),
            editSchoolInformationControllerContext.currentHeader == EditSchoolInformationHeader.organizationMembers ||
                    editSchoolInformationControllerContext.currentHeader == EditSchoolInformationHeader.schoolAddress
                ? Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    elevation: 10,
                    backgroundColor: themeData.calPolyPomonaGreen,
                    foregroundColor: themeData.offWhite,
                    focusElevation: 10,
                    hoverElevation: 12,
                    highlightElevation: 14,
                    tooltip: 'Add',
                    child: const Icon(Icons.add),
                  ),
                )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
