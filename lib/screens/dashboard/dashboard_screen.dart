import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Dashboard',
      child: Container(
        alignment: Alignment.center,
        child: const Text('Dashboard'),
      ),
    );
  }
}
