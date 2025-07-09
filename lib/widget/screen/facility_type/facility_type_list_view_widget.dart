import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/facility_type/facility_type_controller.dart';
import 'package:me_super_admin/widget/screen/facility_type/facility_type_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class FacilityTypeListViewWidget extends StatelessWidget {
  const FacilityTypeListViewWidget({
    super.key,
    required this.onRefresh,
    required this.facilityTypes,
  });

  final Function onRefresh;
  final List<FacilityType> facilityTypes;

  Future<void> deleteFacilityType({
    required BuildContext context,
    required FacilityType facilityType,
  }) async {
    final FacilityTypeController facilityTypeController = Get.put(FacilityTypeController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            facilityTypeController.deleteFacilityType(facilityType.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editFacilityType({
    required BuildContext context,
    required FacilityType facilityType,
  }) async {
    final FacilityTypeController facilityTypeController = Get.put(FacilityTypeController());
    facilityTypeController.setFacilityTypeForm(facilityType);
  }

  void onAddFacilityTypeClicked(BuildContext context) {
    final FacilityTypeController facilityTypeController = Get.put(FacilityTypeController());
    facilityTypeController.resetFacilityTypeForm();
    Navigator.pushNamed(context, RoutePaths.facilityTypeForm);
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
                itemCount: facilityTypes.length,
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
                                () => editFacilityType(
                                  context: context,
                                  facilityType: facilityTypes[index],
                                ),
                          ),
                          DeleteSlidableActionWidget(
                            onDelete:
                                () => deleteFacilityType(
                                  context: context,
                                  facilityType: facilityTypes[index],
                                ),
                          ),
                        ],
                      ),
                      child: FacilityTypeCardWidget(facilityType: facilityTypes[index]),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddFacilityTypeClicked(context),
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
