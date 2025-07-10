import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/facility/facility.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/facility/facility_controller.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/screen/facility/facility_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class FacilityListViewWidget extends StatelessWidget {
  const FacilityListViewWidget({super.key, required this.onRefresh, required this.facilities});

  final Function onRefresh;
  final List<Facility> facilities;

  Future<void> deleteFacility({required BuildContext context, required Facility facility}) async {
    final FacilityController facilityController = Get.put(FacilityController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            facilityController.deleteFacility(facility.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editFacility({required BuildContext context, required Facility facility}) async {
    final FacilityController facilityController = Get.put(FacilityController());
    facilityController.setFacilityForm(facility);
  }

  void onAddFacilityClicked(BuildContext context) {
    final FacilityController facilityController = Get.put(FacilityController());
    facilityController.resetFacilityForm();
    Navigator.pushNamed(context, RoutePaths.facilityForm);
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
                itemCount: facilities.length,
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
                                () => editFacility(context: context, facility: facilities[index]),
                          ),
                          DeleteSlidableActionWidget(
                            onDelete:
                                () => deleteFacility(context: context, facility: facilities[index]),
                          ),
                        ],
                      ),
                      child: FacilityCardWidget(facility: facilities[index]),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddFacilityClicked(context),
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
