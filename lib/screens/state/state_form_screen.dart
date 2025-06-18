import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/screen/state/state_form_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class StateFormScreen extends StatefulWidget {
  const StateFormScreen({super.key});

  @override
  State<StateFormScreen> createState() =>
      _StateFormScreenState();
}

class _StateFormScreenState extends State<StateFormScreen> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'State', child: StateFormWidget());
  }
}
