import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_list_view_widget.dart';

class ActiveSchoolScreen extends StatefulWidget {
  const ActiveSchoolScreen({super.key});

  @override
  State<ActiveSchoolScreen> createState() => _ActiveSchoolScreenState();
}

class _ActiveSchoolScreenState extends State<ActiveSchoolScreen> {
  final SchoolController schoolController = Get.put(SchoolController());

  @override
  void initState() {
    getSchools();
    super.initState();
  }

  Future<void> getSchools() async {
    await Future.delayed(Duration.zero);
    schoolController.getSchools(true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolController>(
      builder: (schoolControllerContext) {
        return ScaffoldWidget(
          title: 'Schools',
          child:
              schoolControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : schoolControllerContext.schools.isEmpty
                  ? NoDataFoundWidget()
                  : SchoolListViewWidget(isActiveData: true, schools: schoolControllerContext.schools, onRefresh: () => getSchools()),
        );
      },
    );
  }
}
