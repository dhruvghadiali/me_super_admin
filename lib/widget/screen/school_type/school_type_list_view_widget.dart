import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/widget/screen/school_type/school_type_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class SchoolTypeListViewWidget extends StatelessWidget {
  const SchoolTypeListViewWidget({super.key, required this.onRefresh, required this.schoolTypes});

  final Function onRefresh;
  final List<SchoolType> schoolTypes;

  Future<void> deleteSchoolType({
    required BuildContext context,
    required SchoolType schoolType,
  }) async {
    final SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            schoolTypeController.deleteSchoolType(schoolType.id);
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
    final SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
    schoolTypeController.setSchoolTypeForm(schoolType);
  }

  void onAddSchoolTypeClicked(BuildContext context) {
    final SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
    schoolTypeController.resetSchoolTypeForm();
    Navigator.pushNamed(context, RoutePaths.schoolTypeForm);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: themeData.offWhite,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60),
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
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddSchoolTypeClicked(context),
                shape: const CircleBorder(),
                elevation: 10,
                backgroundColor: themeData.calPolyPomonaGreen,
                foregroundColor: themeData.offWhite,
                focusElevation: 10,
                hoverElevation: 12,
                highlightElevation: 14,
                tooltip: 'Add',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
