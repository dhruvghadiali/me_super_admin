import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form_fields/icon_button/icon_button_widget.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';

class OrganizationMemberOverviewCardHeaderWidget extends StatelessWidget {
  const OrganizationMemberOverviewCardHeaderWidget({super.key, required this.isNewRecord, required this.index});

  final bool isNewRecord;
  final int index;

  onEditOrganizationMemberButtonClicked(BuildContext context) {
    final OrganizationMemberController organizationMemberController = Get.put(OrganizationMemberController());
    organizationMemberController.setOrganizationFormIndex(index - 1);
    Navigator.pushNamed(context, RoutePaths.organizationMemberForm);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "Member $index".toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold),
          ),
        ),
        isNewRecord
            ? Container()
            : Row(
              children: [
                IconButtonWidget(
                  iconData: Icons.edit_document,
                  iconColor: themeData.offWhite!,
                  onPressed: () => onEditOrganizationMemberButtonClicked(context),
                ),
                IconButtonWidget(iconData: Icons.delete, iconColor: themeData.offWhite!, onPressed: () {}),
              ],
            ),
      ],
    );
  }
}
