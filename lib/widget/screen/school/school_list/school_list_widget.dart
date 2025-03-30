import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/widget/common/card/primary_detail_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/view_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/restore_slidable_action_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_detail/school_primary_detail_widget.dart';

class SchoolListWidget extends StatelessWidget {
  const SchoolListWidget({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: double.infinity,
            child: Slidable(
              key: ValueKey(UniqueKey()),
              endActionPane: ActionPane(
                extentRatio: isActive ? 0.6 : 0.5,
                dragDismissible: false,
                motion: const ScrollMotion(),
                children: [
                  ViewSlidableActionWidget(onView: () => {}),
                  isActive
                      ? EditSlidableActionWidget(onEdit: () => {})
                      : Container(),
                  isActive
                      ? DeleteSlidableActionWidget(onDelete: () => {})
                      : RestoreSlidableActionWidget(onRestore: () => {}),
                ],
              ),
              child: PrimaryDetailCardWidget(
                isActive: isActive,
                child: SchoolPrimaryDetailWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
