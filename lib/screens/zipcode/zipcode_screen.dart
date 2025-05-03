import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/widget/screen/zipcode/zipcode_list_view_widget.dart';

class ZipcodeScreen extends StatefulWidget {
  const ZipcodeScreen({super.key});

  @override
  State<ZipcodeScreen> createState() => _ZipcodeScreenState();
}

class _ZipcodeScreenState extends State<ZipcodeScreen> {
  final ZipcodeController zipcodeController = Get.put(ZipcodeController());

  @override
  void initState() {
    getZipcodes();
    super.initState();
  }

  Future<void> getZipcodes() async {
    await Future.delayed(Duration.zero);
    zipcodeController.getZipcodes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZipcodeController>(
      builder: (zipcodeControllerContext) {
        return ScaffoldWidget(
          title: 'Zipcodes',
          child:
              zipcodeControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : zipcodeControllerContext.zipcodes.isEmpty
                  ? NoDataFoundWidget()
                  : ZipcodeListViewWidget(
                    onRefresh: () => getZipcodes(),
                    zipcodes: zipcodeControllerContext.zipcodes,
                  ),
        );
      },
    );
  }
}
