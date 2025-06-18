import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/district/district_form_widget.dart';

class DistrictFormScreen extends StatefulWidget {
  const DistrictFormScreen({super.key});

  @override
  State<DistrictFormScreen> createState() =>
      _DistrictFormScreenState();
}

class _DistrictFormScreenState extends State<DistrictFormScreen> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'District', child: DistrictFormWidget());
  }
}
