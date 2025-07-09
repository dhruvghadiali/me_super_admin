import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/facility_type/facility_type_form_widget.dart';

class FacilityTypeFormScreen extends StatefulWidget {
  const FacilityTypeFormScreen({super.key});

  @override
  State<FacilityTypeFormScreen> createState() => _FacilityTypeFormScreenState();
}

class _FacilityTypeFormScreenState extends State<FacilityTypeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Facility Type', child: FacilityTypeFormWidget());
  }
}
