import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/controller/academic_grade/academic_grade_controller.dart';
import 'package:me_super_admin/widget/screen/academic_grade/academic_grade_list_view_widget.dart';

class AcademicGradeScreen extends StatefulWidget {
  const AcademicGradeScreen({super.key});

  @override
  State<AcademicGradeScreen> createState() => _AcademicGradeScreenState();
}

class _AcademicGradeScreenState extends State<AcademicGradeScreen> {
  final AcademicGradeController academicGradeController = Get.put(
    AcademicGradeController(),
  );

  @override
  void initState() {
    getAcademicGrades();
    super.initState();
  }

  Future<void> getAcademicGrades() async {
    await Future.delayed(Duration.zero);
    academicGradeController.getAcademicGrades();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademicGradeController>(
      builder: (academicGradeControllerContext) {
        return ScaffoldWidget(
          title: 'School Types',
          child:
              academicGradeControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : academicGradeControllerContext.academicGrades.isEmpty
                  ? NoDataFoundWidget()
                  :AcademicGradeListViewWidget(
                    onRefresh: () => getAcademicGrades(),
                    academicGrades: academicGradeControllerContext.academicGrades,
                  ),
        );
      },
    );
  }
}
