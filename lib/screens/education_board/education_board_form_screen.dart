import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/education_board/education_board_form_widget.dart';

class EducationBoardFormScreen extends StatefulWidget {
  const EducationBoardFormScreen({super.key});

  @override
  State<EducationBoardFormScreen> createState() => _EducationBoardFormScreenState();
}

class _EducationBoardFormScreenState extends State<EducationBoardFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(title: 'Education Board', child: EducationBoardFormWidget());
  }
}
