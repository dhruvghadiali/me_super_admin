import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/screens/school/school_form_stepper_screen.dart';
import 'package:me_super_admin/widget/screen/school/edit_school_information/edit_school_information_widget.dart';

class SchoolFormScreen extends StatefulWidget {
  const SchoolFormScreen({super.key});

  @override
  State<SchoolFormScreen> createState() => _SchoolFormScreenState();
}

class _SchoolFormScreenState extends State<SchoolFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'School',
      child: GetBuilder<SchoolController>(
        builder: (schoolControllerContext) {
          return schoolControllerContext.school.id.isEmpty ? SchoolFormStepperScreen() : EditSchoolInformationWidget();
        },
      ),
    ); // school has id then edit form else new form (Stepper Form)
  }
}
