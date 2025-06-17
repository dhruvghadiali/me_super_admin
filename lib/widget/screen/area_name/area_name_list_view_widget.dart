import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/widget/screen/area_name/area_name_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class AreaNameListViewWidget extends StatelessWidget {
  const AreaNameListViewWidget({super.key, required this.onRefresh, required this.areaNames});

  final Function onRefresh;
  final List<AreaName> areaNames;

  Future<void> deleteAreaName({required BuildContext context, required AreaName areaName}) async {
    final AreaNameController areaNameController = Get.put(AreaNameController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            areaNameController.deleteAreaName(areaName.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editAreaName({required BuildContext context, required AreaName areaName}) async {
    final AreaNameController areaNameController = Get.put(AreaNameController());
    areaNameController.setAreaNameForm(areaName);
  }

  void onAddAreaNameClicked(BuildContext context) {
    final AreaNameController areaNameController = Get.put(AreaNameController());
    areaNameController.resetAreaNameForm();
    Navigator.pushNamed(context, RoutePaths.areaNameForm);
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
            ListView.builder(
              itemCount: areaNames.length,
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
                          onEdit: () => editAreaName(context: context, areaName: areaNames[index]),
                        ),
                        DeleteSlidableActionWidget(
                          onDelete:
                              () => deleteAreaName(context: context, areaName: areaNames[index]),
                        ),
                      ],
                    ),
                    child: AreaNameCardWidget(areaName: areaNames[index]),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddAreaNameClicked(context),
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
