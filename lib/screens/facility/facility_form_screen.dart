import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/facility/facility_form_widget.dart';

class FacilityFormScreen extends StatefulWidget {
  const FacilityFormScreen({super.key});

  @override
  State<FacilityFormScreen> createState() => _FacilityFormScreenState();
}

class _FacilityFormScreenState extends State<FacilityFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Facility', child: FacilityFormWidget());
  }
}
