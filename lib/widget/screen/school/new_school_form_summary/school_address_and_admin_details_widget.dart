import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_text_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_title_widget.dart';

/*
 * Widget: SchoolAddressAndAdminDetailsWidget
 * -----------------------------------------
 * Displays a summary of school addresses and admin details in the new school form summary.
 * Uses GetX to access both SchoolAddressController and SchoolAdminController.
 *
 * If the number of addresses and admins do not match, shows a warning message.
 * Otherwise, lists each address and its corresponding admin.
 */
class SchoolAddressAndAdminDetailsWidget extends StatelessWidget {
  const SchoolAddressAndAdminDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the school address and admin details UI.
     * - Uses AppLocalizations for translated labels.
     * - Uses GetBuilder to listen for changes in the SchoolAddressController.
     * - Accesses SchoolAdminController via Get.find.
     * - Shows a divider and a warning if the address/admin count does not match.
     * - Otherwise, lists each address and its admin.
     */
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return GetBuilder<SchoolAddressController>(
      id: 'school_address_and_admin_summary',
      init: SchoolAddressController(),
      builder: (schoolAddressControllerContext) {
        final schoolAdminController = Get.find<SchoolAdminController>();
        final schoolAddress = schoolAddressControllerContext.schoolAddresses;
        final schoolAdmins = schoolAdminController.schoolAdmins;

        return (schoolAddress.length != schoolAdmins.length)
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: themeData.offWhite, thickness: 1),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    appLocalizations.newSchoolSummarySchoolAddressesAndAdminsMissMatch,
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
                ...schoolAddress.asMap().map((index, address) {
                  return MapEntry(
                    index,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: themeData.offWhite, thickness: 1),
                        SizedBox(height: 20),
                        NewSchoolFormSummaryTabCardTitleWidget(
                          title:
                              "${appLocalizations.newSchoolSummarySchoolAddressTitle.toUpperCase()} ${index + 1}",
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAddressLabelText.toUpperCase(),
                          value:
                              address.address.isNotEmpty
                                  ? address.address
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolStateLabelText.toUpperCase(),
                          value:
                              address.state.name.isNotEmpty
                                  ? address.state.name
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolDistrictLabelText
                                  .toUpperCase(),
                          value:
                              address.district.name.isNotEmpty
                                  ? address.district.name
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title: appLocalizations.newSchoolSummarySchoolCityLabelText.toUpperCase(),
                          value:
                              address.city.name.isNotEmpty
                                  ? address.city.name
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAreaNameLabelText
                                  .toUpperCase(),
                          value:
                              address.areaName.name.isNotEmpty
                                  ? address.areaName.name
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolZipcodeLabelText.toUpperCase(),
                          value:
                              address.zipcode.zipcode.isNotEmpty
                                  ? address.zipcode.zipcode
                                  : appLocalizations.newSchoolSummarySchoolAddressEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTitleWidget(
                          title:
                              "${appLocalizations.newSchoolSummarySchoolAdminTitle.toUpperCase()} ${index + 1}",
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAdminFirstNameLabelText
                                  .toUpperCase(),
                          value:
                              schoolAdmins[index].firstName.isNotEmpty
                                  ? schoolAdmins[index].firstName
                                  : appLocalizations.newSchoolSummarySchoolAdminEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAdminLastNameLabelText
                                  .toUpperCase(),
                          value:
                              schoolAdmins[index].lastName.isNotEmpty
                                  ? schoolAdmins[index].lastName
                                  : appLocalizations.newSchoolSummarySchoolAdminEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAdminEmailLabelText
                                  .toUpperCase(),
                          value:
                              schoolAdmins[index].email.isNotEmpty
                                  ? schoolAdmins[index].email
                                  : appLocalizations.newSchoolSummarySchoolAdminEmptyValue,
                        ),
                        NewSchoolFormSummaryTabCardTextWidget(
                          title:
                              appLocalizations.newSchoolSummarySchoolAdminPhoneNumberLabelText
                                  .toUpperCase(),
                          value:
                              schoolAdmins[index].phoneNumber.isNotEmpty
                                  ? "${appLocalizations.indianPhoneNumberCodeText} ${schoolAdmins[index].phoneNumber}"
                                  : appLocalizations.newSchoolSummarySchoolAdminEmptyValue,
                        ),
                      ],
                    ),
                  );
                }).values,
              ],
            );
      },
    );
  }
}
