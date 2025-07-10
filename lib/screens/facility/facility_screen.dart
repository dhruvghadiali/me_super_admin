import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/controller/facility/facility_controller.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/screen/facility/facility_list_view_widget.dart';

class FacilityScreen extends StatefulWidget {
  const FacilityScreen({super.key});

  @override
  State<FacilityScreen> createState() => _FacilityScreenState();
}

class _FacilityScreenState extends State<FacilityScreen> {
  final FacilityController facilityController = Get.put(FacilityController());

  @override
  void initState() {
    getFacilities();
    super.initState();
  }

  Future<void> getFacilities() async {
    await Future.delayed(Duration.zero);
    facilityController.getFacilities();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FacilityController>(
      builder: (facilityControllerContext) {
        return ScaffoldWidget(
          title: 'Facilities',
          child:
              facilityControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : facilityControllerContext.facilities.isEmpty
                  ? NoDataFoundWidget()
                  : FacilityListViewWidget(
                    onRefresh: () => getFacilities(),
                    facilities: facilityControllerContext.facilities,
                  ),
        );
      },
    );
  }
}
