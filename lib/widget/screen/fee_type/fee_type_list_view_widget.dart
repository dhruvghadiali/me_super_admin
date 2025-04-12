import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/fee_type/fee_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/fee_type/fee_type_controller.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';
import 'package:me_super_admin/widget/screen/fee_type/fee_type_card_widget.dart';

class FeeTypeListViewWidget extends StatelessWidget {
  const FeeTypeListViewWidget({
    super.key,
    required this.onRefresh,
    required this.feeTypes,
  });

  final Function onRefresh;
  final List<FeeType> feeTypes;

  Future<void> deleteFeeType({
    required BuildContext context,
    required FeeType feeType,
  }) async {
    final FeeTypeController feeTypeController = Get.put(FeeTypeController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            feeTypeController.deleteFeeType(feeType.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editFeeType({
    required BuildContext context,
    required FeeType feeType,
  }) async {
    final FeeTypeController feeTypeController = Get.put(FeeTypeController());
    feeTypeController.setFeeTypeForm(feeType);
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
          itemCount: feeTypes.length,
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
                          () => editFeeType(
                            context: context,
                            feeType: feeTypes[index],
                          ),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete:
                          () => deleteFeeType(
                            context: context,
                            feeType: feeTypes[index],
                          ),
                    ),
                  ],
                ),
                child: FeeTypeCardWidget(feeType: feeTypes[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
