import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';

import 'package:me_super_admin/controller/organization/organization_controller.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_text_widget.dart';

/*
 * Widget: OrganizationDetailsWidget
 * ---------------------------------
 * Displays organization details in the new school form summary.
 * Uses GetX to access the OrganizationController and show organization info fields.
 *
 * Shows fields like name, short name, email, phone, registration number, and address.
 */
class OrganizationDetailsWidget extends StatelessWidget {
  const OrganizationDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the organization details UI.
     * - Uses AppLocalizations for translated labels.
     * - Uses GetBuilder to listen for changes in the OrganizationController.
     */
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return GetBuilder<OrganizationController>(
      builder: (organizationControllerContext) {
        final organization = organizationControllerContext.organization;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationNameLabelText,
              value:
                  organization.name.isNotEmpty
                      ? organization.name
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationShortNameLabelText,
              value:
                  organization.shortName.isNotEmpty
                      ? organization.shortName
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationEmailLabelText,
              value:
                  organization.email.isNotEmpty
                      ? organization.email
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationPhoneNumberLabelText,
              value:
                  organization.phoneNumber.isNotEmpty
                      ? "${appLocalizations.indianPhoneNumberCodeText} ${organization.phoneNumber}"
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title:
                  appLocalizations
                      .newSchoolSummaryOrganizationGovernmentRegistrationNumberLabelText,
              value:
                  organization.governmentRegistrationNumber.isNotEmpty
                      ? organization.governmentRegistrationNumber
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationAddressLabelText,
              value:
                  organization.address.isNotEmpty
                      ? organization.address
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationStateLabelText,
              value:
                  organization.state.name.isNotEmpty
                      ? organization.state.name
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationDistrictLabelText,
              value:
                  organization.district.name.isNotEmpty
                      ? organization.district.name
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationCityLabelText,
              value:
                  organization.city.name.isNotEmpty
                      ? organization.city.name
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationAreaNameLabelText,
              value:
                  organization.areaName.name.isNotEmpty
                      ? organization.areaName.name
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummaryOrganizationZipcodeLabelText,
              value:
                  organization.zipcode.zipcode.isNotEmpty
                      ? organization.zipcode.zipcode
                      : appLocalizations.newSchoolSummaryOrganizationEmptyValue,
            ),
          ],
        );
      },
    );
  }
}
