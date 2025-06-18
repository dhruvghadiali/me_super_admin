import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/zipcode/zipcode_form_widget.dart';

class ZipcodeFormScreen extends StatefulWidget {
  const ZipcodeFormScreen({super.key});

  @override
  State<ZipcodeFormScreen> createState() => _ZipcodeFormScreenState();
}

class _ZipcodeFormScreenState extends State<ZipcodeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Zipcode', child: ZipcodeFormWidget());
  }
}
