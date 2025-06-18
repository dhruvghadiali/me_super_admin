import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/screen/district/district_list_view_widget.dart';

class DistrictScreen extends StatefulWidget {
  const DistrictScreen({super.key});

  @override
  State<DistrictScreen> createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  final DistrictController districtController = Get.put(
    DistrictController(),
  );

  @override
  void initState() {
    getDistricts();
    super.initState();
  }

  Future<void> getDistricts() async {
    await Future.delayed(Duration.zero);
    districtController.getDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistrictController>(
      builder: (districtControllerContext) {
        return ScaffoldWidget(
          title: 'Districts',
          child:
              districtControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : districtControllerContext.districts.isEmpty
                  ? NoDataFoundWidget()
                  :DistrictListViewWidget(
                    onRefresh: () => getDistricts(),
                    districts: districtControllerContext.districts,
                  ),
        );
      },
    );
  }
}
