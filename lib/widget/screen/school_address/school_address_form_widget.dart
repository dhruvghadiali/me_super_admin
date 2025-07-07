import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/model/school_address/school_address.dart';
import 'package:me_super_admin/widget/common/form/city_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/zipcode_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/area_name_selection_form_widget.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SchoolAddressFormWidget extends StatefulWidget {
  const SchoolAddressFormWidget({
    super.key,
    required this.schoolAddress,
    required this.index,
    required this.onSubmitForm,
  });

  final SchoolAddress schoolAddress;
  final int index;
  final Function onSubmitForm;

  @override
  State<SchoolAddressFormWidget> createState() => _SchoolAddressFormWidgetState();
}

class _SchoolAddressFormWidgetState extends State<SchoolAddressFormWidget> {
  // Importing the SchoolAddressController using GetX for state management.
  final SchoolAddressController schoolAddressController = Get.put(SchoolAddressController());

  /*
   * Global keys used for form validation and accessing specific form field states.
   * _formKey: Tracks the overall form state (validation, submission).
   * _<fieldName>FieldKey: Allows direct access to specific form fields for validation, focus, or error handling.
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _zipcodeFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _addressFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _areaNameFieldKey = GlobalKey<FormFieldState>();

  /*
   * FocusNodes used to manage the focus state of individual form fields.
   * These nodes are responsible for controlling the focus and blur events of the corresponding form fields.
   * They are helpful in navigating between form fields and handling focus-related behaviors (e.g., moving to the next field on submit).
   */
  final FocusNode _addressFocusNode = FocusNode();

  /*
   * TextEditingControllers used to manage and manipulate the text input in form fields. These controllers allow you to:
   * 
   * - Retrieve and update the text entered by the user in each corresponding form field.
   * - Validate input, reset text fields, and retrieve user input for form submission.
   * 
   * Useful for controlling text field values programmatically and listening for changes in user input.
   */
  final TextEditingController _addressTextEditingController = TextEditingController();

  @override
  void initState() {
    /*
     * Initializes the state of the widget.
     *
     * If the `schoolAddress` object passed to the widget has a non-empty `id`,
     * it populates the text fields with the corresponding values from the object.
     * This ensures that the form is pre-filled with existing data when editing a
     * school address.
     */
    SchoolAddress schoolAddress = widget.schoolAddress;
    _addressTextEditingController.text = schoolAddress.address;
    super.initState();
  }

  /*
   * Handles the submission of the address text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the address text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Submits the address value to the controller for validation and state update.
   */
  void onAddressTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    schoolAddressController.onAddressSubmitted(value, widget.index, _addressFieldKey);
  }

  /*
   * Handles the form submission.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   *
   * Explanation:
   * - Unfocused any currently focused text field.
   * - Validates the form using `_formKey`.
   * - Calls the `onSubmitForm` callback with `true` if the form is valid, otherwise with `false`.
   */
  void onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmitForm(true);
    } else {
      widget.onSubmitForm(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: GetBuilder<SchoolAddressController>(
        builder: (schoolAddressControllerContext) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _addressFieldKey,
                    focusNode: _addressFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _addressTextEditingController,
                    labelText: appLocalizations.schoolAddressFormAddressTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: schoolAddressControllerContext.addressValidator,
                    onChange:
                        (String value) =>
                            schoolAddressControllerContext.onAddressChange(value, widget.index),
                    onFieldSubmitted: (String value) => onAddressTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: StateSelectionFormWidget(
                    formFieldKey: _stateFieldKey,
                    validator: schoolAddressControllerContext.stateValidator,
                    selectedState:
                        schoolAddressControllerContext.schoolAddresses[widget.index].state,
                    onChange:
                        (state_model.State state) => schoolAddressControllerContext.onStateChange(
                          state,
                          widget.index,
                          _stateFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DistrictSelectionFormWidget(
                    formFieldKey: _districtFieldKey,
                    validator: schoolAddressControllerContext.districtValidator,
                    selectedDistrict:
                        schoolAddressControllerContext.schoolAddresses[widget.index].district,
                    selectedState:
                        schoolAddressControllerContext.schoolAddresses[widget.index].state,
                    onChange:
                        (District district) => schoolAddressControllerContext.onDistrictChange(
                          district,
                          widget.index,
                          _districtFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: CitySelectionFormWidget(
                    formFieldKey: _cityFieldKey,
                    validator: schoolAddressControllerContext.cityValidator,
                    selectedCity: schoolAddressControllerContext.schoolAddresses[widget.index].city,
                    selectedDistrict:
                        schoolAddressControllerContext.schoolAddresses[widget.index].district,
                    onChange:
                        (City city) => schoolAddressControllerContext.onCityChange(
                          city,
                          widget.index,
                          _cityFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: AreaNameSelectionFormWidget(
                    formFieldKey: _areaNameFieldKey,
                    validator: schoolAddressControllerContext.areaNameValidator,
                    selectedAreaName:
                        schoolAddressControllerContext.schoolAddresses[widget.index].areaName,
                    selectedCity: schoolAddressControllerContext.schoolAddresses[widget.index].city,
                    onChange:
                        (AreaName areaName) => schoolAddressControllerContext.onAreaNameChange(
                          areaName,
                          widget.index,
                          _areaNameFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: ZipcodeSelectionFormWidget(
                    formFieldKey: _zipcodeFieldKey,
                    validator: schoolAddressControllerContext.zipcodeValidator,
                    selectedAreaName:
                        schoolAddressControllerContext.schoolAddresses[widget.index].areaName,
                    selectedZipcode:
                        schoolAddressControllerContext.schoolAddresses[widget.index].zipcode,
                    onChange:
                        (Zipcode zipcode) => schoolAddressControllerContext.onZipcodeChange(
                          zipcode,
                          widget.index,
                          _zipcodeFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.submitButtonText.toUpperCase(),
                          disabled: false,
                          onPressed: () => onSubmitForm(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
