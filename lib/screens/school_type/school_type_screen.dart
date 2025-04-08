
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/widget/screen/school_type/school_type_list_view_widget.dart';

class SchoolTypeScreen extends StatefulWidget {
  const SchoolTypeScreen({super.key});

  @override
  State<SchoolTypeScreen> createState() => _SchoolTypeScreenState();
}

class _SchoolTypeScreenState extends State<SchoolTypeScreen> {

  final SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());

  @override
  void initState() {
    // TODO: implement initState
    getSchoolTypes();
    super.initState();
  }
  
  Future<void> getSchoolTypes() async {
    await Future.delayed(Duration.zero);
    schoolTypeController.getSchoolTypes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolTypeController>(
      builder: (schoolTypeControllerContext) {
        return  ScaffoldWidget(
          title: 'School Types',
          child: SchoolTypeListViewWidget(onRefresh: () => getSchoolTypes(), schoolTypes: schoolTypeControllerContext.schoolTypes,),
        );
      }
    );
  }
}
