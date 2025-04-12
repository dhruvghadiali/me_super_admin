import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/education_board/education_board.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/education_board/education_board_controller.dart';
import 'package:me_super_admin/widget/screen/education_board/education_board_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class EducationBoardListViewWidget extends StatelessWidget {
  const EducationBoardListViewWidget({
    super.key,
    required this.onRefresh,
    required this.educationBoards,
  });

  final Function onRefresh;
  final List<EducationBoard> educationBoards;

  Future<void> deleteEducationBoard({
    required BuildContext context,
    required EducationBoard educationBoard,
  }) async {
    final EducationBoardController educationBoardController = Get.put(
      EducationBoardController(),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            educationBoardController.deleteEducationBoard(educationBoard.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editEducationBoard({
    required BuildContext context,
    required EducationBoard educationBoard,
  }) async {
    final EducationBoardController educationBoardController = Get.put(
      EducationBoardController(),
    );
    educationBoardController.setEducationBoardForm(educationBoard);
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
          itemCount: educationBoards.length,
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
                          () => editEducationBoard(
                            context: context,
                            educationBoard: educationBoards[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteEducationBoard(
                            context: context,
                            educationBoard: educationBoards[index],
                          ),
                    ),
                  ],
                ),
                child: EducationBoardCardWidget(
                  educationBoard: educationBoards[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
