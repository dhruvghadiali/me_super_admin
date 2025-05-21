import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/alert/alert_widget.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/widget/screen/school_address/school_address_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';

class SchoolAddressesFormWidget extends StatefulWidget {
  const SchoolAddressesFormWidget({super.key, required this.isStepperForm, this.onNextStep, this.onPreviousStep});

  final bool isStepperForm;
  final Function? onNextStep;
  final Function? onPreviousStep;

  @override
  State<SchoolAddressesFormWidget> createState() => _SchoolAddressesFormWidgetState();
}

class _SchoolAddressesFormWidgetState extends State<SchoolAddressesFormWidget> {
  final SchoolAddressController schoolAddressController = Get.put(SchoolAddressController());

  /*
   * Displays an alert dialog when validation fails.
   *
   * This function shows a dialog with a validation alert message. The dialog
   * prevents dismissal by tapping outside and provides a button to close it.
   */
  void displayAlert() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertWidget(
          message: appLocalizations.organizationMemberFormValidationAlertMessage,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  /*
   * Checks if all school address forms are validated.
   *
   * This function iterates through the `schoolAddressFormValidated` list to find
   * any form that is not validated. If any form is invalid, it returns `true`,
   * otherwise `false`.
   *
   * Returns:
   * - `true` if any form is invalid.
   * - `false` if all forms are valid.
   */
  bool isSchoolAddressesFormValidated() {
    int index = schoolAddressController.schoolAddressFormValidated.indexOf(false);
    return index != -1;
  }

  /*
   * Handles the expansion state change of an `ExpansionTile`.
   *
   * Parameters:
   * - `expanded`: A boolean indicating whether the tile is expanded or collapsed.
   * - `index`: The index of the organization member form associated with the tile.
   */
  void onExpansionChanged(bool expanded, int index) {}

  /*
   * Proceeds to the next step in the stepper form.
   *
   * If any form is invalid, it displays an alert. Otherwise, it calls the `onNextStep`
   * callback provided by the parent widget.
   */
  void onNextStep() => isSchoolAddressesFormValidated() ? displayAlert() : widget.onNextStep!();

  /*
   * Returns to the previous step in the stepper form.
   *
   * If any form is invalid, it displays an alert. Otherwise, it calls the `onPreviousStep`
   * callback provided by the parent widget.
   */
  void onPreviousStep() => isSchoolAddressesFormValidated() ? displayAlert() : widget.onPreviousStep!();

  /*
   * Adds a new school address form.
   *
   * This function calls the controller to add a new form to the list of school
   * address forms and updates the UI.
   */
  void addNewSchoolAddressForm() => schoolAddressController.addSchoolAddressForm();

  /*
   * Handles the submission of a school address form.
   *
   * Parameters:
   * - `status`: A boolean indicating whether the form is valid.
   * - `index`: The index of the form being submitted.
   *
   * Explanation:
   * - If `isStepperForm` is true, it updates the validation status of the form.
   * - Otherwise, it either saves the form data or displays an alert if invalid.
   */
  void onSchoolAddressFormSubmit(bool status, int index) {
    if (widget.isStepperForm) {
      schoolAddressController.changeSchoolAddressFormValidatedStatus(index, status);
    } else {
      status ? schoolAddressController.putSchoolAddress(index) : displayAlert();
    }
  }

  /*
   * Deletes a school address form.
   *
   * Parameters:
   * - `index`: The index of the form to be deleted.
   *
   * Explanation:
   * - If `isStepperForm` is true, it removes the form from the list.
   * - Otherwise, it deletes the form data from the backend.
   */
  void deleteSchoolAddressForm(int index) {
    if (widget.isStepperForm) {
      schoolAddressController.deleteSchoolAddressForm(index);
    } else {
      schoolAddressController.deleteSchoolAddress(index);
    }
  }

  /*
   * Builds the UI for the school addresses form widget.
   *
   * This function uses a `GetBuilder` to rebuild the widget whenever the state
   * of the `SchoolAddressController` changes. It displays a list of
   * `ExpansionTile` widgets, each representing a school address form.
   *
   * If `isStepperForm` is true, navigation buttons for the next and previous
   * steps are displayed at the bottom.
   *
   * Returns:
   * - A `Column` widget containing the list of forms and navigation buttons.
   */
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return GetBuilder<SchoolAddressController>(
      builder: (schoolAddressControllerContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: null,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: themeData.eerieBlack, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                  onPressed: () => addNewSchoolAddressForm(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle, color: themeData.offWhite),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(appLocalizations.addSchoolAddressButtonText, style: TextStyle(color: themeData.offWhite)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ...schoolAddressController.schoolAddresses.asMap().entries.map((entry) {
              return ExpansionTile(
                onExpansionChanged: (bool expanded) => onExpansionChanged(expanded, entry.key),
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
                tilePadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.delete, color: themeData.metallicRed, size: 22), onPressed: () => deleteSchoolAddressForm(entry.key)),
                    Expanded(
                      child: Text(
                        '${appLocalizations.schoolAddressFormExpansionTile} ${entry.key + 1}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeData.eerieBlack, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: SchoolAddressFormWidget(
                      schoolAddress: entry.value,
                      index: entry.key,
                      onSubmitForm: (bool status) => onSchoolAddressFormSubmit(status, entry.key),
                    ),
                  ),
                ],
              );
            }),
            widget.isStepperForm
                ? Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.nextButtonText,
                          disabled: false,
                          onPressed: () => onNextStep(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.previousButtonText,
                          disabled: false,
                          onPressed: () => onPreviousStep(),
                        ),
                      ),
                    ],
                  ),
                )
                : Container(),
          ],
        );
      },
    );
  }
}
