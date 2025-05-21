import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_super_admin/model/stepper/school_form_stepper.dart';

class SchoolFormStepperController extends GetxController {
  List<SchoolFormStepper> schoolFormStepper = SchoolFormStepper.defaultValues();
  int currentIndex = 0;

  void resetStepper() {
    schoolFormStepper = SchoolFormStepper.defaultValues();
    currentIndex = 0;
    update();
  }

  void nextStep() {
    SchoolFormStepper currentStep = schoolFormStepper[currentIndex];
    currentStep = currentStep.copyWith(isActive: false, stepState: StepState.complete, formState: StepState.complete);
    schoolFormStepper[currentIndex] = currentStep;

    if (currentIndex < schoolFormStepper.length - 1) {
      SchoolFormStepper nextStep = schoolFormStepper[currentIndex + 1];
      nextStep = nextStep.copyWith(isActive: true, stepState: StepState.editing, formState: StepState.editing);
      schoolFormStepper[currentIndex + 1] = nextStep;
      currentIndex++;
    }
    update();
  }

  void previousStep() {
    SchoolFormStepper currentStep = schoolFormStepper[currentIndex];
    currentStep = currentStep.copyWith(isActive: false, stepState: StepState.complete, formState: StepState.complete);
    schoolFormStepper[currentIndex] = currentStep;

    if (currentIndex > 0) {
      SchoolFormStepper previousStep = schoolFormStepper[currentIndex - 1];
      previousStep = previousStep.copyWith(isActive: true, stepState: StepState.editing, formState: StepState.editing);
      schoolFormStepper[currentIndex - 1] = previousStep;
      currentIndex--;
    }
    update();
  }

  void onStepTapped(int index) {
    update();
  }
}
