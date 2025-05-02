import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/city/city_list_view_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final CityController cityController = Get.put(CityController());

  @override
  void initState() {
    getCities();
    super.initState();
  }

  Future<void> getCities() async {
    await Future.delayed(Duration.zero);
    cityController.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CityController>(
      builder: (cityControllerContext) {
        return ScaffoldWidget(
          title: 'Cities',
          child:
              cityControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : cityControllerContext.cities.isEmpty
                  ? NoDataFoundWidget()
                  : CityListViewWidget(
                    onRefresh: () => getCities(),
                    cities: cityControllerContext.cities,
                  ),
        );
      },
    );
  }
}
