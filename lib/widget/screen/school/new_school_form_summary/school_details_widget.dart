import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_text_widget.dart';

/*
 * Widget: SchoolDetailsWidget
 * --------------------------
 * Displays school details in the new school form summary.
 * Uses GetX to access the SchoolController and show school info fields.
 *
 * Shows fields like affiliate number, name, short name, email, phone, established year, and school type.
 */
class SchoolDetailsWidget extends StatelessWidget {
  const SchoolDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * Builds the school details UI.
     * - Uses AppLocalizations for translated labels.
     * - Uses GetBuilder to listen for changes in the SchoolController.
     */
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return GetBuilder<SchoolController>(
      builder: (schoolControllerContext) {
        final school = schoolControllerContext.school;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolAffiliateNumberLabelText.toUpperCase(),
              value: school.affiliateNumber.isNotEmpty ? school.affiliateNumber : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolNameLabelText.toUpperCase(),
              value: school.name.isNotEmpty ? school.name : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolShortNameLabelText.toUpperCase(),
              value: school.shortName.isNotEmpty ? school.shortName : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolEmailLabelText.toUpperCase(),
              value: school.email.isNotEmpty ? school.email : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolPhoneNumberLabelText.toUpperCase(),
              value:
                  school.phoneNumber.isNotEmpty
                      ? "${appLocalizations.indianPhoneNumberCodeText} ${school.phoneNumber}"
                      : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolEstablishedYearLabelText.toUpperCase(),
              value: school.establishedYear.toString().isNotEmpty ? school.establishedYear.toString() : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolTypeLabelText.toUpperCase(),
              value: school.schoolType.schoolType.isNotEmpty ? school.schoolType.schoolType : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
            NewSchoolFormSummaryTabCardTextWidget(
              title: appLocalizations.newSchoolSummarySchoolEducationBoardsLabelText.toUpperCase(),
              value:
                  school.educationBoards.isNotEmpty
                      ? school.educationBoards.map((e) => e.educationBoard).toList().join(", ")
                      : appLocalizations.newSchoolSummarySchoolEmptyValue,
            ),
          ],
        );
      },
    );
  }
}
