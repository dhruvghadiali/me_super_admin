import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/screen/state/state_list_view_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';

class StateScreen extends StatefulWidget {
  const StateScreen({super.key});

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  final StateController stateController = Get.put(
    StateController(),
  );

  @override
  void initState() {
    getStates();
    super.initState();
  }

  Future<void> getStates() async {
    await Future.delayed(Duration.zero);
    stateController.getStates();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(
      builder: (stateControllerContext) {
        return ScaffoldWidget(
          title: 'States',
          child: stateControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : stateControllerContext.states.isEmpty
                  ? NoDataFoundWidget()
                  :StateListViewWidget(
                    onRefresh: () => getStates(),
                    states: stateControllerContext.states,
                  ),
        );
      },
    );
  }
}
