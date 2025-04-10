import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/school_type/school_type_form_widget.dart';

class SchoolTypeRegisterScreen extends StatefulWidget {
  const SchoolTypeRegisterScreen({super.key});

  @override
  State<SchoolTypeRegisterScreen> createState() =>
      _SchoolTypeRegisterScreenState();
}

class _SchoolTypeRegisterScreenState extends State<SchoolTypeRegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'School Type', child: SchoolTypeFormWidget());
  }
}
