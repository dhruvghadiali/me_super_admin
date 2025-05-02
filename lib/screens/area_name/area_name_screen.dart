import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/screen/area_name/area_name_list_view_widget.dart';

class AreaNameScreen extends StatefulWidget {
  const AreaNameScreen({super.key});

  @override
  State<AreaNameScreen> createState() => _AreaNameScreenState();
}

class _AreaNameScreenState extends State<AreaNameScreen> {
  final AreaNameController areaNameController = Get.put(AreaNameController());

  @override
  void initState() {
    getAreaNames();
    super.initState();
  }

  Future<void> getAreaNames() async {
    await Future.delayed(Duration.zero);
    areaNameController.getAreaNames();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AreaNameController>(
      builder: (areaNameControllerContext) {
        return ScaffoldWidget(
          title: 'Area Names',
          child:
              areaNameControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : areaNameControllerContext.areaNames.isEmpty
                  ? NoDataFoundWidget()
                  : AreaNameListViewWidget(
                    onRefresh: () => getAreaNames(),
                    areaNames: areaNameControllerContext.areaNames,
                  ),
        );
      },
    );
  }
}
