import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/academic_class/academic_class.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/academic_class/academic_class_controller.dart';
import 'package:me_super_admin/widget/screen/academic_class/academic_class_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class AcademicClassListViewWidget extends StatelessWidget {
  const AcademicClassListViewWidget({
    super.key,
    required this.onRefresh,
    required this.academicClasses,
  });

  final Function onRefresh;
  final List<AcademicClass> academicClasses;

  Future<void> deleteAcademicClass({
    required BuildContext context,
    required AcademicClass academicClass,
  }) async {
    final AcademicClassController academicClassController = Get.put(AcademicClassController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            academicClassController.deleteAcademicClass(academicClass.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editAcademicClass({
    required BuildContext context,
    required AcademicClass academicClass,
  }) async {
    final AcademicClassController academicClassController = Get.put(AcademicClassController());
    academicClassController.setAcademicClassForm(academicClass);
  }

  void onAddAcademicClassClicked(BuildContext context) {
    final AcademicClassController academicClassController = Get.put(AcademicClassController());
    academicClassController.resetAcademicClassForm();
    Navigator.pushNamed(context, RoutePaths.academicClassForm);
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
                itemCount: academicClasses.length,
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
                                () => editAcademicClass(
                                  context: context,
                                  academicClass: academicClasses[index],
                                ),
                          ),
                          DeleteSlidableActionWidget(
                            onDelete:
                                () => deleteAcademicClass(
                                  context: context,
                                  academicClass: academicClasses[index],
                                ),
                          ),
                        ],
                      ),
                      child: AcademicClassCardWidget(academicClass: academicClasses[index]),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddAcademicClassClicked(context),
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
