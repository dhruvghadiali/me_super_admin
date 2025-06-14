import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/alert/alert_widget.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_member_form_widget.dart';

class OrganizationMembersFormWidget extends StatefulWidget {
  const OrganizationMembersFormWidget({super.key, required this.isStepperForm, this.onNextStep, this.onPreviousStep});

  final bool isStepperForm;
  final Function? onNextStep;
  final Function? onPreviousStep;

  @override
  State<OrganizationMembersFormWidget> createState() => _OrganizationMembersFormWidgetState();
}

class _OrganizationMembersFormWidgetState extends State<OrganizationMembersFormWidget> {
  final OrganizationMemberController organizationMemberController = Get.put(OrganizationMemberController());

  /*
   * Displays an alert dialog when validation fails.
   *
   * This function shows a dialog with a validation alert message. The dialog
   * prevents dismissal by tapping outside and provides a button to close it.
   */
  void displayAlert({String? message}) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertWidget(
          message: message ?? appLocalizations.organizationMemberFormValidationAlertMessage,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  /*
   * Checks if all organization member forms are validated.
   *
   * This function iterates through the `organizationMemberFormValidated` list to find
   * any form that is not validated. If any form is invalid, it returns `true`,
   * otherwise `false`.
   *
   * Returns:
   * - `true` if any form is invalid.
   * - `false` if all forms are valid.
   */
  bool isOrganizationMembersFormValidated() {
    int index = organizationMemberController.organizationMemberFormValidated.indexOf(false);
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
  void onNextStep() => isOrganizationMembersFormValidated() ? displayAlert() : widget.onNextStep!();

  /*
   * Returns to the previous step in the stepper form.
   *
   * If any form is invalid, it displays an alert. Otherwise, it calls the `onPreviousStep`
   * callback provided by the parent widget.
   */
  void onPreviousStep() => isOrganizationMembersFormValidated() ? displayAlert() : widget.onPreviousStep!();

  /*
   * Adds a new organization member form.
   *
   * This function calls the controller to add a new form to the list of organization
   * member forms and updates the UI.
   */
  void addNewOrganizationMemberForm() => organizationMemberController.addOrganizationMemberForm();

  /*
   * Handles the submission of an organization member form.
   *
   * Parameters:
   * - `status`: A boolean indicating whether the form is valid.
   * - `index`: The index of the form being submitted.
   *
   * Explanation:
   * - If `isStepperForm` is true, it updates the validation status of the form.
   * - Otherwise, it either saves the form data or displays an alert if invalid.
   */
  void onOrganizationMemberFormSubmit(bool status, int index) {
    if (widget.isStepperForm) {
      organizationMemberController.changeOrganizationMemberFormValidatedStatus(index, status);
    }
  }

  /*
   * Deletes an organization member form.
   *
   * Parameters:
   * - `index`: The index of the form to be deleted.
   *
   * Explanation:
   * - If `isStepperForm` is true, it removes the form from the list.
   * - Otherwise, it deletes the form data from the backend.
   */
  void deleteOrganizationMemberForm(int index) {
    if (widget.isStepperForm) {
      if (organizationMemberController.organizationMembers.length > 1) {
        organizationMemberController.deleteOrganizationMemberForm(index);
      } else {
        displayAlert(message: "At least one organization member is required.");
      }
    } else {
      organizationMemberController.deleteOrganizationMember(index);
    }
  }

  /*
   * Builds the UI for the organization members form widget.
   *
   * This function uses a `GetBuilder` to rebuild the widget whenever the state
   * of the `OrganizationMemberController` changes. It displays a list of
   * `ExpansionTile` widgets, each representing an organization member form.
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

    return GetBuilder<OrganizationMemberController>(
      builder: (organizationMemberControllerContext) {
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
                  onPressed: () => addNewOrganizationMemberForm(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle, color: themeData.offWhite),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(appLocalizations.organizationMemberFormAddMemberButtonText.toUpperCase(), style: TextStyle(color: themeData.offWhite)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ...organizationMemberControllerContext.organizationMembers.asMap().entries.map((entry) {
              return ExpansionTile(
                onExpansionChanged: (bool expanded) => onExpansionChanged(expanded, entry.key),
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
                tilePadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.delete, color: themeData.metallicRed, size: 22), onPressed: () => deleteOrganizationMemberForm(entry.key)),
                    Expanded(
                      child: Text(
                        '${appLocalizations.organizationMemberFormExpansionTile} ${entry.key + 1}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeData.eerieBlack, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: OrganizationMemberFormWidget(
                      organizationMember: entry.value,
                      index: entry.key,
                      isStepper: true,
                      onSubmitForm: (bool status) => onOrganizationMemberFormSubmit(status, entry.key),
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
                          buttonText: appLocalizations.nextButtonText.toUpperCase(),
                          disabled: false,
                          onPressed: () => onNextStep(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.previousButtonText.toUpperCase(),
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
