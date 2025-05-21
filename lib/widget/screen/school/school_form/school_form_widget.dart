import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/school/school.dart';
import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/model/education_board/education_board.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/widget/common/alert/alert_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';
import 'package:me_super_admin/controller/education_board/education_board_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SchoolFormWidget extends StatefulWidget {
  const SchoolFormWidget({super.key, required this.isStepperForm, this.onNextStep, this.onPreviousStep});

  final bool isStepperForm;
  final Function? onNextStep;
  final Function? onPreviousStep;

  @override
  State<SchoolFormWidget> createState() => _SchoolFormWidgetState();
}

class _SchoolFormWidgetState extends State<SchoolFormWidget> {
  // Importing the SchoolController, SchoolTypeController, and EducationBoardController using GetX for state management.
  final SchoolController schoolController = Get.put(SchoolController());
  final SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
  final EducationBoardController educationBoardController = Get.put(EducationBoardController());

  /*
   * Global keys used for form validation and accessing specific form field states.
   * _formKey: Tracks the overall form state (validation, submission).
   * _<fieldName>FieldKey: Allows direct access to specific form fields for validation, focus, or error handling.
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _nameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _shortNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _schoolTypeFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _educationBoardFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _affiliateNumberFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _establishedYearFieldKey = GlobalKey<FormFieldState>();

  /*
   * FocusNodes used to manage the focus state of individual form fields.
   * These nodes are responsible for controlling the focus and blur events of the corresponding form fields.
   * They are helpful in navigating between form fields and handling focus-related behaviors (e.g., moving to the next field on submit).
   */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _shortNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _affiliateNumberFocusNode = FocusNode();
  final FocusNode _establishedYearFocusNode = FocusNode();

  /*
   * TextEditingControllers used to manage the text input for individual form fields.
   * These controllers are responsible for retrieving and updating the text value of the corresponding form fields.
   * They are useful for pre-filling form fields with existing data (e.g., when editing an existing school).
   */
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _shortNameTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();
  final TextEditingController _affiliateNumberTextEditingController = TextEditingController();
  final TextEditingController _establishedYearTextEditingController = TextEditingController();

  /*
   * The initState() method is called when the widget is inserted into the widget tree.
   * It is used here to initialize the form fields with data from the schoolController:
   *
   * - If the school ID is not empty, the relevant fields (name, email, phone number, etc.) are populated with the corresponding values
   *  from the schoolController's school object.
   *
   * This ensures that the form fields are pre-filled with the school's data when the screen is loaded.
   *
   * The super.initState() call ensures that the parent class's initState is also called.
   */
  @override
  void initState() {
    if (schoolController.school.id.isNotEmpty) {
      School school = schoolController.school;
      _nameTextEditingController.text = school.name;
      _shortNameTextEditingController.text = school.shortName;
      _emailTextEditingController.text = school.email;
      _phoneNumberTextEditingController.text = school.phoneNumber;
      _affiliateNumberTextEditingController.text = school.affiliateNumber;
      _establishedYearTextEditingController.text = school.establishedYear.toString();
    }
    super.initState();
  }

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
   * The validateFormValues method is used to validate the form fields.
   * It checks if the form is valid and returns true if all fields are valid, otherwise false.
   *
   * This method is useful for ensuring that the user has filled out all required fields correctly before proceeding with form submission.
   */
  bool validateFormValues() => _formKey.currentState?.validate() ?? false;

  /*
   * The onAffiliateNumberTextFieldSubmit method is triggered when the user submits the affiliate number input field.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the affiliate number text field).
   * 2. Requests focus on the next field (the name text field) using the _nameFocusNode.
   * 3. Calls the schoolController.onAffiliateNumberSubmitted method to handle the submission logic.
   *    The _affiliateNumberFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onAffiliateNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_nameFocusNode);
    schoolController.onAffiliateNumberSubmitted(value, _affiliateNumberFieldKey);
  }

  /*
   * The onNameTextFieldSubmit method is triggered when the user submits the name input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the name text field).
   * 2. Requests focus on the next field (the short name text field) using the _shortNameFocusNode.
   * 3. Calls the schoolController.onNameSubmitted method to handle the submission logic.
   *    The _nameFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_shortNameFocusNode);
    schoolController.onNameSubmitted(value, _nameFieldKey);
  }

  /*
   * The onShortNameTextFieldSubmit method is triggered when the user submits the short name input field.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the short name text field).
   * 2. Requests focus on the next field (the email text field) using the _emailFocusNode.
   * 3. Calls the schoolController.onShortNameSubmitted method to handle the submission logic.
   *    The _shortNameFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onShortNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_emailFocusNode);
    schoolController.onShortNameSubmitted(value, _shortNameFieldKey);
  }

  /*
   * The onEmailTextFieldSubmit method is triggered when the user submits the email input field.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the email text field).
   * 2. Requests focus on the next field (the phone number text field) using the _phoneNumberFocusNode.
   * 3. Calls the schoolController.onEmailSubmitted method to handle the submission logic.
   *    The _emailFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onEmailTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    schoolController.onEmailSubmitted(value, _emailFieldKey);
  }

  /*
   * The onPhoneNumberTextFieldSubmit method is triggered when the user submits the phone number input field.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the phone number text field).
   * 2. Requests focus on the next field (the established year text field) using the _establishedYearFocusNode.
   * 3. Calls the schoolController.onPhoneNumberSubmitted method to handle the submission logic.
   *    The _phoneNumberFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onPhoneNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_establishedYearFocusNode);
    schoolController.onPhoneNumberSubmitted(value, _phoneNumberFieldKey);
  }

  /*
   * The onEstablishedYearTextFieldSubmit method is triggered when the user submits the established year input field.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the established year text field).
   * 2. Calls the schoolController.onEstablishedYearSubmitted method to handle the submission logic.
   *    The _establishedYearFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onEstablishedYearTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    schoolController.onEstablishedYearSubmitted(value, _establishedYearFieldKey);
  }

  /*
   * The onSchoolTypeChange method is triggered when the user selects a school type from the dropdown.
   * It performs the following actions:
   *
   * 1. Creates a default SchoolType object.
   * 2. If the selected value is not empty, it finds the corresponding SchoolType object from the list of school types.
   * 3. Calls the schoolController.onSchoolTypeChange method to handle the change logic.
   *    The _schoolTypeFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures that the selected school type is properly handled and updated in the controller.
   */
  void onSchoolTypeChange(String value) {
    SchoolType schoolType = SchoolType.defaultValues();
    if (value.isNotEmpty) {
      schoolType = schoolTypeController.schoolTypes.firstWhere((schoolType) => schoolType.id == value, orElse: () => schoolType);
    }

    schoolController.onSchoolTypeChange(schoolType, _schoolTypeFieldKey);
  }

  /*
   * The onEducationBoardChange method is triggered when the user selects an education board from the dropdown.
   * It performs the following actions:
   *
   * 1. Creates an empty list of EducationBoard objects.
   * 2. If the selected value is not empty, it splits the value into a list of selected items and finds the corresponding EducationBoard
   * objects from the list of education boards.
   * 3. Calls the schoolController.onEducationBoardsChange method to handle the change logic.
   *    The _educationBoardFieldKey is passed to provide access to the form field for validation or other actions.
   *
   * This method ensures that the selected education boards are properly handled and updated in the controller.
   */
  void onEducationBoardChange(String value) {
    List<EducationBoard> educationBoards = [];
    if (value.isNotEmpty) {
      List<String> selectedItems = value.split(',');
      educationBoards = educationBoardController.educationBoards.where((educationBoard) => selectedItems.contains(educationBoard.id)).toList();
    }

    schoolController.onEducationBoardsChange(educationBoards, _educationBoardFieldKey);
  }

  /*
   * The onSubmitForm method is triggered when the user submits the form.
   * It performs the following actions:
   *
   * 1. Unfocused the current focus node (i.e., removes the focus from the current field).
   * 2. If the school ID is not empty, it calls the schoolController.onSubmitForm method to handle the form submission logic.
   *
   * This method ensures that the form is properly submitted and any necessary actions are taken based on the school ID.
   */
  void onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (schoolController.school.id.isNotEmpty) {
      // If the school is already created, we need to update the school.
      schoolController.onSubmitForm(_formKey);
    }
  }

  /*
   * The onNextStep method is triggered when the user clicks the "Next" button in the stepper form.
   * It performs the following actions:
   *
   * 1. If the form values are valid, it calls the onNextStep callback provided by the parent widget.
   * 2. If the form values are not valid, it displays an alert dialog.
   *
   * This method ensures that the user can only proceed to the next step if all required fields are filled out correctly.
   */
  void onNextStep() {
    if (validateFormValues()) {
      widget.onNextStep!();
    } else {
      displayAlert();
    }
  }

  /*
   * The onPreviousStep method is triggered when the user clicks the "Previous" button in the stepper form.
   * It performs the following actions:
   *
   * 1. If the form values are valid, it calls the onPreviousStep callback provided by the parent widget.
   * 2. If the form values are not valid, it displays an alert dialog.
   *
   * This method ensures that the user can only go back to the previous step if all required fields are filled out correctly.
   */
  void onPreviousStep() {
    if (validateFormValues()) {
      widget.onPreviousStep!();
    } else {
      displayAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: GetBuilder<SchoolController>(
        builder: (schoolControllerContext) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _affiliateNumberFieldKey,
                    focusNode: _affiliateNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _affiliateNumberTextEditingController,
                    labelText: appLocalizations.schoolAffiliateNumberTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.affiliateNumberValidator,
                    onChange: (String value) => schoolControllerContext.onAffiliateNumberChange(value),
                    onFieldSubmitted: (String value) => onAffiliateNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _nameFieldKey,
                    focusNode: _nameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _nameTextEditingController,
                    labelText: appLocalizations.schoolNameTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.nameValidator,
                    onChange: (String value) => schoolControllerContext.onNameChange(value),
                    onFieldSubmitted: (String value) => onNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _shortNameFieldKey,
                    focusNode: _shortNameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _shortNameTextEditingController,
                    labelText: appLocalizations.schoolShortNameTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.shortNameValidator,
                    onChange: (String value) => schoolControllerContext.onShortNameChange(value),
                    onFieldSubmitted: (String value) => onShortNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _emailFieldKey,
                    focusNode: _emailFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailTextEditingController,
                    labelText: appLocalizations.schoolEmailTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.emailValidator,
                    onChange: (String value) => schoolControllerContext.onEmailChange(value),
                    onFieldSubmitted: (String value) => onEmailTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _phoneNumberFieldKey,
                    focusNode: _phoneNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberTextEditingController,
                    labelText: appLocalizations.phoneNumberTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.phoneNumberValidator,
                    onChange: (String value) => schoolControllerContext.onPhoneNumberChange(value),
                    onFieldSubmitted: (String value) => onPhoneNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _establishedYearFieldKey,
                    focusNode: _establishedYearFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.number,
                    controller: _establishedYearTextEditingController,
                    labelText: appLocalizations.schoolEstablishedYearTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolControllerContext.establishedYearValidator,
                    onChange: (String value) => schoolControllerContext.onEstablishedYearChange(value),
                    onFieldSubmitted: (String value) => onEstablishedYearTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DropdownWidget(
                    fieldKey: _schoolTypeFieldKey,
                    validator: schoolControllerContext.schoolTypeValidator,
                    labelText: appLocalizations.schoolTypeDropdownFieldLabelText,
                    selectedItem: schoolControllerContext.school.schoolType.id,
                    appColorScheme: AppColorScheme.primary,
                    onChanged: (String value) => onSchoolTypeChange(value),
                    items:
                        schoolTypeController.schoolTypes.isEmpty
                            ? []
                            : schoolTypeController.schoolTypes
                                .map((SchoolType schoolType) => {'label': schoolType.schoolType, "value": schoolType.id})
                                .toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DropdownWidget(
                    fieldKey: _educationBoardFieldKey,
                    validator: schoolControllerContext.educationBoardValidator,
                    labelText: appLocalizations.educationBoardDropdownFieldLabelText,
                    multiSelection: true,
                    selectedItem:
                        schoolControllerContext.school.educationBoards.isEmpty
                            ? ""
                            : schoolControllerContext.school.educationBoards.map((educationBoard) => educationBoard.id).where((id) => id.isNotEmpty).join(','),
                    appColorScheme: AppColorScheme.primary,
                    onChanged: (String value) => onEducationBoardChange(value),
                    items:
                        educationBoardController.educationBoards.isEmpty
                            ? []
                            : educationBoardController.educationBoards
                                .map((EducationBoard educationBoard) => {'label': educationBoard.educationBoard, "value": educationBoard.id})
                                .toList(),
                  ),
                ),
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
                    : Column(
                      children: [
                        schoolControllerContext.isLoader ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary) : Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: ElevatedButtonWidget(
                            appColorScheme: AppColorScheme.primary,
                            buttonText: appLocalizations.submitButtonText,
                            disabled: schoolControllerContext.isLoader,
                            onPressed: () => onSubmitForm(context),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
