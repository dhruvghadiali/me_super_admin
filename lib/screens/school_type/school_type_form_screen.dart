import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/school_type/school_type_form_widget.dart';

class SchoolTypeFormScreen extends StatefulWidget {
  const SchoolTypeFormScreen({super.key});

  @override
  State<SchoolTypeFormScreen> createState() => _SchoolTypeFormScreenState();
}

class _SchoolTypeFormScreenState extends State<SchoolTypeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'School Type', child: SchoolTypeFormWidget());
  }
}
