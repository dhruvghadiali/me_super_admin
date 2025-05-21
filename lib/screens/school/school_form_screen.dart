import 'package:flutter/material.dart';
import 'package:me_super_admin/screens/school/school_form_stepper_screen.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class SchoolFormScreen extends StatefulWidget {
  const SchoolFormScreen({super.key});

  @override
  State<SchoolFormScreen> createState() => _SchoolFormScreenState();
}

class _SchoolFormScreenState extends State<SchoolFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'School', child: SchoolFormStepperScreen());
  }
}
