import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/area_name/area_name_form_widget.dart';

class AreaNameFormScreen extends StatefulWidget {
  const AreaNameFormScreen({super.key});

  @override
  State<AreaNameFormScreen> createState() => _AreaNameFormScreenState();
}

class _AreaNameFormScreenState extends State<AreaNameFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Area Name', child: AreaNameFormWidget());
  }
}
