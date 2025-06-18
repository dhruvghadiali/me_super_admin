import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/screen/city/city_form_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class CityFormScreen extends StatefulWidget {
  const CityFormScreen({super.key});

  @override
  State<CityFormScreen> createState() => _CityFormScreenState();
}

class _CityFormScreenState extends State<CityFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'City', child: CityFormWidget());
  }
}
