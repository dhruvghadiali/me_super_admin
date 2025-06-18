import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/school_details_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/organization_details_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/organization_member_details_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/school_address_and_admin_details_widget.dart';

/*
 * Widget: NewSchoolFormSummaryTabCardWidget
 * -----------------------------------------
 * Main container for displaying summary sections in the new school form summary.
 * Shows organization, organization members, school, and school address/admin details based on boolean flags.
 *
 * Props:
 *   - showOrganization: Show organization details section (bool)
 *   - showOrganizationMembers: Show organization members section (bool)
 *   - showSchool: Show school details section (bool)
 *   - showSchoolAddresses: Show school addresses section (bool)
 *   - showSchoolAdmins: Show school admins section (bool)
 */
class NewSchoolFormSummaryTabCardWidget extends StatelessWidget {
  const NewSchoolFormSummaryTabCardWidget({
    super.key,
    required this.showOrganization,
    required this.showOrganizationMembers,
    required this.showSchool,
    required this.showSchoolAddresses,
    required this.showSchoolAdmins,
  });

  final bool showOrganization;
  final bool showOrganizationMembers;
  final bool showSchool;
  final bool showSchoolAddresses;
  final bool showSchoolAdmins;

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the summary card UI.
     * - Uses a Card for elevation and background color.
     * - Shows/hides sections based on the provided boolean flags.
     * - Scrollable for long content.
     */
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Card(
      color: themeData.eerieBlack,
      elevation: 20,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 450,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showOrganization ? OrganizationDetailsWidget() : const SizedBox.shrink(),
                showOrganizationMembers ? OrganizationMemberDetailsWidget() : const SizedBox.shrink(),
                showSchool ? const SchoolDetailsWidget() : const SizedBox.shrink(),
                showSchoolAddresses && showSchoolAdmins ? const SchoolAddressAndAdminDetailsWidget() : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
