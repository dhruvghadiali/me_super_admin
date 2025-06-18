import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/controller/academic_class/academic_class_controller.dart';
import 'package:me_super_admin/widget/screen/academic_class/academic_class_list_view_widget.dart';

class AcademicClassScreen extends StatefulWidget {
  const AcademicClassScreen({super.key});

  @override
  State<AcademicClassScreen> createState() => _AcademicClassScreenState();
}

class _AcademicClassScreenState extends State<AcademicClassScreen> {
  final AcademicClassController academicClassController = Get.put(AcademicClassController());

  @override
  void initState() {
    getAcademicClasses();
    super.initState();
  }

  Future<void> getAcademicClasses() async {
    await Future.delayed(Duration.zero);
    academicClassController.getAcademicClasses();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademicClassController>(
      builder: (academicClassControllerContext) {
        return ScaffoldWidget(
          title: 'Academic Classes',
          child:
              academicClassControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : academicClassControllerContext.academicClasses.isEmpty
                  ? NoDataFoundWidget()
                  : AcademicClassListViewWidget(
                    onRefresh: () => getAcademicClasses(),
                    academicClasses: academicClassControllerContext.academicClasses,
                  ),
        );
      },
    );
  }
}
