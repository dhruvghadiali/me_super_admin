import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/controller/fee_type/fee_type_controller.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/screen/fee_type/fee_type_list_view_widget.dart';

class FeeTypeScreen extends StatefulWidget {
  const FeeTypeScreen({super.key});

  @override
  State<FeeTypeScreen> createState() => _FeeTypeScreenState();
}

class _FeeTypeScreenState extends State<FeeTypeScreen> {
  final FeeTypeController feeTypeController = Get.put(
    FeeTypeController(),
  );

  @override
  void initState() {
    getFeeTypes();
    super.initState();
  }

  Future<void> getFeeTypes() async {
    await Future.delayed(Duration.zero);
    feeTypeController.getFeeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeeTypeController>(
      builder: (feeTypeControllerContext) {
        return ScaffoldWidget(
          title: 'FeeR Types',
          child:
              feeTypeControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : feeTypeControllerContext.feeTypes.isEmpty
                  ? NoDataFoundWidget()
                  : FeeTypeListViewWidget(
                    onRefresh: () => getFeeTypes(),
                    feeTypes: feeTypeControllerContext.feeTypes,
                  ),
        );
      },
    );
  }
}
