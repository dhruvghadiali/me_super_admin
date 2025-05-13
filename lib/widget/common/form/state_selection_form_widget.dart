import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class StateSelectionFormWidget extends StatelessWidget {
  const StateSelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedState,

    required this.onChange,
    required this.validator,
  });

  final state_model.State selectedState;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onStateChange(String value, List<state_model.State> states) {
    if (value != selectedState.id) {
      state_model.State stateInfo = state_model.State.defaultValues();

      if (value.isNotEmpty) {
        stateInfo = states.firstWhere((state) => state.id == value);
      }

      onChange(stateInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<StateController>(
      builder: (stateControllerContext) {
        return DropdownWidget(
          fieldKey: formFieldKey,
          validator: validator,
          labelText: appLocalizations.stateDropdownFieldLabelText,
          selectedItem: selectedState.id,
          appColorScheme: AppColorScheme.primary,
          onChanged:
              (String value) =>
                  onStateChange(value, stateControllerContext.states),
          items:
              stateControllerContext.states.isEmpty
                  ? []
                  : stateControllerContext.states
                      .map((state) => {'label': state.name, "value": state.id})
                      .toList(),
        );
      },
    );
  }
}
