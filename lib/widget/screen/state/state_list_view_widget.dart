import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/widget/screen/state/state_card_widget.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';

class StateListViewWidget extends StatelessWidget {
  const StateListViewWidget({super.key, required this.onRefresh, required this.states});

  final Function onRefresh;
  final List<state_model.State> states;

  Future<void> deleteState({
    required BuildContext context,
    required state_model.State state,
  }) async {
    final StateController stateController = Get.put(StateController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            stateController.deleteState(state.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editState({required BuildContext context, required state_model.State state}) async {
    final StateController stateController = Get.put(StateController());
    stateController.setStateForm(state);
  }

  void onAddStateClicked(BuildContext context) {
    final StateController stateController = Get.put(StateController());
    stateController.resetStateForm();
    Navigator.pushNamed(context, RoutePaths.stateForm);
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
                itemCount: states.length,
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
                            onEdit: () => editState(context: context, state: states[index]),
                          ),
                          DeleteSlidableActionWidget(
                            onDelete: () => deleteState(context: context, state: states[index]),
                          ),
                        ],
                      ),
                      child: StateCardWidget(state: states[index]),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => onAddStateClicked(context),
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
