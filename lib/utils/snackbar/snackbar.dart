import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/theme_data_util.dart';

class Snackbar extends GetxController {
  static void getSnackbar({
    required String title,
    required String message,
    required AppSnackbarStatus appSnackbarStatus,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor(appSnackbarStatus),
      colorText: ThemeDataUtil.isabelline,
      icon: Icon(
        setSnackbarIcon(appSnackbarStatus),
        color: ThemeDataUtil.isabelline,
        size: 45,
      ),
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
    );
  }

  static Color backgroundColor(AppSnackbarStatus snackbarDisplayStatus) {
    switch (snackbarDisplayStatus) {
      case AppSnackbarStatus.success:
        return ThemeDataUtil.calPolyPomonaGreen;
      case AppSnackbarStatus.warning:
        return ThemeDataUtil.harvestGold;
      case AppSnackbarStatus.error:
        return ThemeDataUtil.metallicRed;
    }
  }

  static IconData setSnackbarIcon(AppSnackbarStatus snackbarDisplayStatus) {
    switch (snackbarDisplayStatus) {
      case AppSnackbarStatus.success:
        return Icons.check_circle_rounded;
      case AppSnackbarStatus.warning:
        return Icons.warning_rounded;
      case AppSnackbarStatus.error:
        return Icons.error_rounded;
    }
  }
}
