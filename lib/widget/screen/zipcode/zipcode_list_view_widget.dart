import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/screen/zipcode/zipcode_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class ZipcodeListViewWidget extends StatelessWidget {
  const ZipcodeListViewWidget({super.key, required this.onRefresh, required this.zipcodes});

  final Function onRefresh;
  final List<Zipcode> zipcodes;

  Future<void> deleteZipcode({required BuildContext context, required Zipcode zipcode}) async {
    final ZipcodeController zipcodeController = Get.put(ZipcodeController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            zipcodeController.deleteZipcode(zipcode.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editZipcode({required BuildContext context, required Zipcode zipcode}) async {
    final ZipcodeController zipcodeController = Get.put(ZipcodeController());
    zipcodeController.setZipcodeForm(zipcode);
  }

  void onAddZipcodeClicked(BuildContext context) {
    final ZipcodeController zipcodeController = Get.put(ZipcodeController());
    zipcodeController.resetZipcodeForm();
    Navigator.pushNamed(context, RoutePaths.zipcodeForm);
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
              itemCount: zipcodes.length,
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
                          onEdit: () => editZipcode(context: context, zipcode: zipcodes[index]),
                        ),
                        DeleteSlidableActionWidget(
                          onDelete: () => deleteZipcode(context: context, zipcode: zipcodes[index]),
                        ),
                      ],
                    ),
                    child: ZipcodeCardWidget(zipcode: zipcodes[index]),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddZipcodeClicked(context),
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
