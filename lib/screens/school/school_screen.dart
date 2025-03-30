import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      title: 'Schools',
      child: Text('Schools Screen'),
    );
  }
}