import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/academic_grade/academic_grade.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/academic_grade/academic_grade_controller.dart';
import 'package:me_super_admin/widget/screen/academic_grade/academic_grade_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class AcademicGradeListViewWidget extends StatelessWidget {
  const AcademicGradeListViewWidget({
    super.key,
    required this.onRefresh,
    required this.academicGrades,
  });

  final Function onRefresh;
  final List<AcademicGrade> academicGrades;

  Future<void> deleteAcademicGrade({
    required BuildContext context,
    required AcademicGrade academicGrade,
  }) async {
    final AcademicGradeController academicGradeController = Get.put(
      AcademicGradeController(),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            academicGradeController.deleteAcademicGrade(academicGrade.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editAcademicGrade({
    required BuildContext context,
    required AcademicGrade academicGrade,
  }) async {
    final AcademicGradeController academicGradeController = Get.put(
      AcademicGradeController(),
    );
    academicGradeController.setAcademicGradeForm(academicGrade);
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
          itemCount: academicGrades.length,
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
                          () => editAcademicGrade(
                            context: context,
                            academicGrade: academicGrades[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteAcademicGrade(
                            context: context,
                            academicGrade: academicGrades[index],
                          ),
                    ),
                  ],
                ),
                child: AcademicGradeCardWidget(
                  academicGrade: academicGrades[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
