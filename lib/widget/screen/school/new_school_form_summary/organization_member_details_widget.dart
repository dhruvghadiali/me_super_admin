import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_text_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_title_widget.dart';

/*
 * Widget: OrganizationMemberDetailsWidget
 * --------------------------------------
 * Displays a list of organization members in the new school form summary.
 * Uses GetX to access the OrganizationMemberController and show member info fields.
 *
 * Shows a message if no members are found, otherwise lists each member's details.
 */
class OrganizationMemberDetailsWidget extends StatelessWidget {
  const OrganizationMemberDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the organization member details UI.
     * - Uses AppLocalizations for translated labels.
     * - Uses GetBuilder to listen for changes in the OrganizationMemberController.
     * - Shows a divider and a message if no members are found.
     * - Otherwise, lists each member's details with a title and labeled fields.
     */
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return GetBuilder<OrganizationMemberController>(
      builder: (organizationMemberControllerContext) {
        final organizationMembers = organizationMemberControllerContext.organizationMembers;
        return organizationMembers.isEmpty
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: themeData.offWhite, thickness: 1),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    appLocalizations.newSchoolSummaryOrganizationMembersNotFound,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: themeData.offWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: themeData.offWhite, thickness: 1),
                SizedBox(height: 20),
                ...organizationMembers.map((organizationMember) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NewSchoolFormSummaryTabCardTitleWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberTitle.toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberFirstNameLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.firstName.isNotEmpty
                                ? organizationMember.firstName
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberLastNameLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.lastName.isNotEmpty
                                ? organizationMember.lastName
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberEmailLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.email.isNotEmpty
                                ? organizationMember.email
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberPhoneNumberLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.phoneNumber.isNotEmpty
                                ? "${appLocalizations.indianPhoneNumberCodeText} ${organizationMember.phoneNumber}"
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations
                                .newSchoolSummaryOrganizationMemberAadhaarNumberLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.aadhaarNumber.isNotEmpty
                                ? organizationMember.aadhaarNumber
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberPositionLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.position.isNotEmpty
                                ? organizationMember.position
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberAddressLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.address.isNotEmpty
                                ? organizationMember.address
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberStateLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.state.name.isNotEmpty
                                ? organizationMember.state.name
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberDistrictLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.district.name.isNotEmpty
                                ? organizationMember.district.name
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberCityLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.city.name.isNotEmpty
                                ? organizationMember.city.name
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberAreaNameLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.areaName.name.isNotEmpty
                                ? organizationMember.areaName.name
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                      NewSchoolFormSummaryTabCardTextWidget(
                        title:
                            appLocalizations.newSchoolSummaryOrganizationMemberZipcodeLabelText
                                .toUpperCase(),
                        value:
                            organizationMember.zipcode.zipcode.isNotEmpty
                                ? organizationMember.zipcode.zipcode
                                : appLocalizations.newSchoolSummaryOrganizationMemberEmptyValue
                                    .toUpperCase(),
                      ),
                    ],
                  );
                }),
              ],
            );
      },
    );
  }
}
