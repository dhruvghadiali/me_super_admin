import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';

class FacilityScreen extends StatelessWidget {
  const FacilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      title: 'Facilities',
      child: Text('Facilities Screen'),
    );
  }
}