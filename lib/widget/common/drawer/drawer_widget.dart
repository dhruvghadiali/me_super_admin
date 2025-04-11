import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/drawer_items.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/controller/academic_grade/academic_grade_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  void onDrawerClick(BuildContext context, String route) {
    switch (route) {
      case RoutePaths.schoolTypeForm || RoutePaths.schoolTypes:
        SchoolTypeController schoolTypeController = Get.put(
          SchoolTypeController(),
        );
        schoolTypeController.resetSchoolTypeForm();
        break;
      case RoutePaths.academicGradeForm || RoutePaths.academicGrades:
        AcademicGradeController academicGradeController = Get.put(
          AcademicGradeController(),
        );
        academicGradeController.resetAcademicGradeForm();
        break;
      default:
        break;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: themeData.offWhite),
            child: Text(''),
          ),
          ...drawerItems.map(
            (item) =>
                item.submenu.isNotEmpty
                    ? ExpansionTile(
                      collapsedIconColor: themeData.offWhite,
                      iconColor: themeData.offWhite,
                      leading: Icon(item.icon, color: themeData.offWhite),
                      title: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: themeData.offWhite),
                      ),
                      children:
                          item.submenu
                              .map(
                                (submenuItem) => ListTile(
                                  contentPadding: EdgeInsets.only(left: 50),
                                  leading: Icon(
                                    submenuItem.icon,
                                    color: themeData.offWhite,
                                    size: 20,
                                  ),
                                  title: Text(
                                    submenuItem.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: themeData.offWhite),
                                  ),
                                  onTap:
                                      () => onDrawerClick(
                                        context,
                                        submenuItem.route,
                                      ),
                                ),
                              )
                              .toList(),
                    )
                    : ListTile(
                      iconColor: themeData.offWhite,
                      leading: Icon(item.icon, color: themeData.offWhite),
                      title: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: themeData.offWhite),
                      ),
                      onTap: () => onDrawerClick(context, item.route),
                    ),
          ),
        ],
      ),
    );
  }
}
