import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/fee_type/fee_type_form_widget.dart';

class FeeTypeFormScreen extends StatefulWidget {
  const FeeTypeFormScreen({super.key});

  @override
  State<FeeTypeFormScreen> createState() => _FeeTypeFormScreenState();
}

class _FeeTypeFormScreenState extends State<FeeTypeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Fee Type', child: FeeTypeFormWidget());
  }
}
