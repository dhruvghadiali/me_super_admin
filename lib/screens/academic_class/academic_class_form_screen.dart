import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/academic_class/academic_class_form_widget.dart';

class AcademicClassFormScreen extends StatefulWidget {
  const AcademicClassFormScreen({super.key});

  @override
  State<AcademicClassFormScreen> createState() => _AcademicClassFormScreenState();
}

class _AcademicClassFormScreenState extends State<AcademicClassFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Academic Class', child: AcademicClassFormWidget());
  }
}
