import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/widget/common/loader/loader_widget.dart';
import 'package:me_super_admin/widget/common/scaffold/scaffold_widget.dart';
import 'package:me_super_admin/widget/common/container/no_data_found_widget.dart';
import 'package:me_super_admin/controller/education_board/education_board_controller.dart';
import 'package:me_super_admin/widget/screen/education_board/education_board_list_view_widget.dart';

class EducationBoardScreen extends StatefulWidget {
  const EducationBoardScreen({super.key});

  @override
  State<EducationBoardScreen> createState() => _EducationBoardScreenState();
}

class _EducationBoardScreenState extends State<EducationBoardScreen> {
  final EducationBoardController educationBoardController = Get.put(
    EducationBoardController(),
  );

  @override
  void initState() {
    getEducationBoards();
    super.initState();
  }

  Future<void> getEducationBoards() async {
    await Future.delayed(Duration.zero);
    educationBoardController.getEducationBoards();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EducationBoardController>(
      builder: (educationBoardControllerContext) {
        return ScaffoldWidget(
          title: 'Education Board',
          child:
              educationBoardControllerContext.isLoader
                  ? LoaderWidget(appColorScheme: AppColorScheme.primary)
                  : educationBoardControllerContext.educationBoards.isEmpty
                  ? NoDataFoundWidget()
                  : EducationBoardListViewWidget(
                    onRefresh: () => getEducationBoards(),
                    educationBoards: educationBoardControllerContext.educationBoards,
                  ),
        );
      },
    );
  }
}
