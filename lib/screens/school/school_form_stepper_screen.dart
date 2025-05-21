import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';

import 'package:me_super_admin/model/stepper/school_form_stepper.dart';
import 'package:me_super_admin/controller/school/school_form_stepper_controller.dart';
import 'package:me_super_admin/widget/screen/organization/organization_form_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_form/school_form_widget.dart';
import 'package:me_super_admin/widget/screen/school_admin/school_admins_form_widget.dart';
import 'package:me_super_admin/widget/screen/school_address/school_addresses_form_widget.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_members_form_widget.dart';

/*
 * SchoolFormStepperScreen is a StatefulWidget that manages a multi-step form (stepper) for school-related data entry.
 *
 * - It uses GetX for state management and navigation between steps.
 * - The stepper consists of several steps, each represented by a different form widget:
 *   1. OrganizationFormWidget
 *   2. OrganizationMembersFormWidget
 *   3. SchoolFormWidget
 *   4. SchoolAddressesFormWidget
 *   5. SchoolAdminsFormWidget
 * - The getStepperContent method returns the appropriate widget for each step based on the current step's name.
 * - Each form widget receives callbacks for onNextStep and onPreviousStep to control navigation.
 * - The build method uses GetBuilder to rebuild the UI when the stepper controller changes state.
 * - The Stepper widget displays the steps, their titles, subtitles, and content, and manages the current step index.
 * - Controls for moving between steps are handled by the form widgets themselves, not by the Stepper's default controls.
 */
class SchoolFormStepperScreen extends StatefulWidget {
  const SchoolFormStepperScreen({super.key});

  @override
  State<SchoolFormStepperScreen> createState() => _SchoolFormStepperScreenState();
}

class _SchoolFormStepperScreenState extends State<SchoolFormStepperScreen> {
  final SchoolFormStepperController schoolFormStepperController = Get.put(SchoolFormStepperController());

  /*
   * Returns the widget corresponding to the current step in the stepper.
   *
   * - schoolFormStepper: The current step's data (contains stepName, title, etc.).
   * - index: The index of the current step.
   * - Uses a switch statement to determine which form widget to show for each step.
   * - Each widget is passed callbacks for navigation (onNextStep, onPreviousStep) as needed.
   */
  Widget getStepperContent(SchoolFormStepper schoolFormStepper, int index) {
    switch (schoolFormStepper.stepName) {
      case SchoolFormStepName.organization:
        // Organization step: shows the organization form
        return OrganizationFormWidget(isStepperForm: true, onNextStep: () => schoolFormStepperController.nextStep());
      case SchoolFormStepName.organizationMembers:
        // Organization members step: shows the organization members form
        return OrganizationMembersFormWidget(
          isStepperForm: true,
          onNextStep: () => schoolFormStepperController.nextStep(),
          onPreviousStep: () => schoolFormStepperController.previousStep(),
        );
      case SchoolFormStepName.school:
        // School step: shows the school form
        return SchoolFormWidget(
          isStepperForm: true,
          onNextStep: () => schoolFormStepperController.nextStep(),
          onPreviousStep: () => schoolFormStepperController.previousStep(),
        );
      case SchoolFormStepName.schoolAddresses:
        // School addresses step: shows the school addresses form
        return SchoolAddressesFormWidget(
          isStepperForm: true,
          onNextStep: () => schoolFormStepperController.nextStep(),
          onPreviousStep: () => schoolFormStepperController.previousStep(),
        );
      case SchoolFormStepName.schoolAdmin:
        // School admin step: shows the school admins form
        return SchoolAdminsFormWidget(
          isStepperForm: true,
          onNextStep: () => schoolFormStepperController.nextStep(),
          onPreviousStep: () => schoolFormStepperController.previousStep(),
        );
    }
  }

  /*
   * Builds the UI for the stepper screen.
   *
   * - Uses GetBuilder to listen to changes in the SchoolFormStepperController.
   * - Displays a Stepper widget with all steps, titles, subtitles, and content.
   * - The content for each step is provided by getStepperContent.
   * - Step navigation is handled by the form widgets, so Stepper controls are hidden.
   */
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolFormStepperController>(
      builder: (schoolFormStepperControllerContext) {
        return Column(
          children: [
            Expanded(
              child: Stepper(
                onStepTapped: (int index) => schoolFormStepperControllerContext.onStepTapped(index),
                currentStep: schoolFormStepperControllerContext.currentIndex,
                controlsBuilder: (context, details) => SizedBox(),
                steps:
                    schoolFormStepperControllerContext.schoolFormStepper.asMap().entries.map((entry) {
                      int index = entry.key;
                      var step = entry.value;
                      return Step(
                        title: Text(step.title),
                        subtitle: Text(step.subtitle),
                        isActive: step.isActive,
                        state: step.stepState,
                        content: getStepperContent(step, index),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
