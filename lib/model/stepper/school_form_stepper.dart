import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';

class SchoolFormStepper {
  String title;
  String subtitle;
  bool isActive;
  StepState stepState;
  StepState formState;
  SchoolFormStepName stepName;

  SchoolFormStepper({
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.stepState,
    required this.formState,
    required this.stepName,
  });

  SchoolFormStepper copyWith({String? title, String? subtitle, bool? isActive, StepState? stepState, StepState? formState, SchoolFormStepName? stepName}) =>
      SchoolFormStepper(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        isActive: isActive ?? this.isActive,
        stepState: stepState ?? this.stepState,
        formState: formState ?? this.formState,
        stepName: stepName ?? this.stepName,
      );

  static List<SchoolFormStepper> defaultValues() => [
    SchoolFormStepper(
      title: 'Organization',
      subtitle: 'Organization Details',
      isActive: true,
      stepState: StepState.editing,
      formState: StepState.editing,
      stepName: SchoolFormStepName.organization,
    ),
    SchoolFormStepper(
      title: 'Organization Members',
      subtitle: 'Organization Members',
      isActive: false,
      stepState: StepState.disabled,
      formState: StepState.disabled,
      stepName: SchoolFormStepName.organizationMembers,
    ),
    SchoolFormStepper(
      title: 'School',
      subtitle: 'School Details',
      isActive: false,
      stepState: StepState.disabled,
      formState: StepState.disabled,
      stepName: SchoolFormStepName.school,
    ),
    SchoolFormStepper(
      title: 'School Addresses',
      subtitle: 'School Addresses',
      isActive: false,
      stepState: StepState.disabled,
      formState: StepState.disabled,
      stepName: SchoolFormStepName.schoolAddresses,
    ),
    SchoolFormStepper(
      title: 'School Admin',
      subtitle: 'School Admin',
      isActive: false,
      stepState: StepState.disabled,
      formState: StepState.disabled,
      stepName: SchoolFormStepName.schoolAdmin,
    ),
  ];
}
