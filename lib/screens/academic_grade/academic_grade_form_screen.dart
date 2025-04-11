import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/academic_grade/academic_grade_form_widget.dart';

class AcademicGradeFormScreen extends StatefulWidget {
  const AcademicGradeFormScreen({super.key});

  @override
  State<AcademicGradeFormScreen> createState() =>
      _AcademicGradeFormScreenState();
}

class _AcademicGradeFormScreenState extends State<AcademicGradeFormScreen> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Academic Grade', child: AcademicGradeFormWidget());
  }
}
