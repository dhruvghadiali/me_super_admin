import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/screen/district/district_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class DistrictListViewWidget extends StatelessWidget {
  const DistrictListViewWidget({
    super.key,
    required this.onRefresh,
    required this.districts,
  });

  final Function onRefresh;
  final List<District> districts;

  Future<void> deleteDistrict({
    required BuildContext context,
    required District district,
  }) async {
    final DistrictController districtController = Get.put(DistrictController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            districtController.deleteDistrict(district.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editDistrict({
    required BuildContext context,
    required District district,
  }) async {
    final DistrictController districtController = Get.put(DistrictController());
    districtController.setDistrictForm(district);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: themeData.offWhite,
        child: ListView.builder(
          itemCount: districts.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: double.infinity,
              child: Slidable(
                key: ValueKey(UniqueKey()),
                endActionPane: ActionPane(
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  children: [
                    EditSlidableActionWidget(
                      onEdit:
                          () => editDistrict(
                            context: context,
                            district: districts[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteDistrict(
                            context: context,
                            district: districts[index],
                          ),
                    ),
                  ],
                ),
                child: DistrictCardWidget(district: districts[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
