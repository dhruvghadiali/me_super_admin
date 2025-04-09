import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/widget/screen/school_type/school_type_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';

class SchoolTypeListViewWidget extends StatelessWidget {
  const SchoolTypeListViewWidget({
    super.key,
    required this.onRefresh,
    required this.schoolTypes,
  });

  final Function onRefresh;
  final List<SchoolType> schoolTypes;

  Future<void> deleteSchoolType({
    required BuildContext context,
    required SchoolType schoolType,
  }) async {
    final SchoolTypeController schoolTypeController = Get.put(
      SchoolTypeController(),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            schoolTypeController.deleteSchoolTypes(schoolType.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editSchoolType({
    required BuildContext context,
    required SchoolType schoolType,
  }) async {
    // final CityController cityController = Get.put(CityController());
    // cityController.navigateToCityForm(cityDetail: cityDetail);
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
          itemCount: schoolTypes.length,
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
                          () => editSchoolType(
                            context: context,
                            schoolType: schoolTypes[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteSchoolType(
                            context: context,
                            schoolType: schoolTypes[index],
                          ),
                    ),
                  ],
                ),
                child: SchoolTypeCardWidget(schoolType: schoolTypes[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
