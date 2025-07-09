import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/controller/facility_type/facility_type_controller.dart';
import 'package:me_super_admin/widget/screen/facility_type/facility_type_list_view_widget.dart';

class FacilityTypeScreen extends StatefulWidget {
  const FacilityTypeScreen({super.key});

  @override
  State<FacilityTypeScreen> createState() => _FacilityTypeScreenState();
}

class _FacilityTypeScreenState extends State<FacilityTypeScreen> {
  final FacilityTypeController facilityTypeController = Get.put(FacilityTypeController());

  @override
  void initState() {
    getFacilityTypes();
    super.initState();
  }

  Future<void> getFacilityTypes() async {
    await Future.delayed(Duration.zero);
    facilityTypeController.getFacilityTypes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FacilityTypeController>(
      builder: (facilityTypeControllerContext) {
        return ScaffoldWidget(
          title: 'Facility Types',
          child:
              facilityTypeControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : facilityTypeControllerContext.facilityTypes.isEmpty
                  ? NoDataFoundWidget()
                  : FacilityTypeListViewWidget(
                    onRefresh: () => getFacilityTypes(),
                    facilityTypes: facilityTypeControllerContext.facilityTypes,
                  ),
        );
      },
    );
  }
}
