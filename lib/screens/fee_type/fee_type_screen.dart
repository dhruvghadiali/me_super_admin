import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class FeeTypeScreen extends StatelessWidget {
  const FeeTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      title: 'Fees Types',
      child: Text('Fees Types Screen'),
    );
  }
}