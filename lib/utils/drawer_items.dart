import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/drawer_item/drawer_item.dart';

List<DrawerItem> drawerItems = [
  DrawerItem(
    title: 'Dashboard',
    icon: Icons.speed_rounded,
    route: '/dashboard',
    submenu: [],
  ),
  DrawerItem(
    title: 'Manage Schools',
    icon: Icons.school,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Active Schools',
        icon: Icons.check_circle,
        route: '/schools/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Schools',
        icon: Icons.remove_circle,
        route: '/schools/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Schools',
        icon: Icons.add_circle,
        route: '/schools/register',
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Faculties',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Active Faculties',
        icon: Icons.check_circle,
        route: '/faculties/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Faculties',
        icon: Icons.remove_circle,
        route: '/faculties/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Faculties',
        icon: Icons.add_circle,
        route: '/faculties/register',
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Fee Types',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Active Fee Types',
        icon: Icons.check_circle,
        route: RoutePaths.feeTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Fee Types',
        icon: Icons.remove_circle,
        route: RoutePaths.feeTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Eduction Boards',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Eduction Boards',
        icon: Icons.check_circle,
        route: RoutePaths.educationBoards,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Eduction Boards',
        icon: Icons.remove_circle,
        route: RoutePaths.educationBoardForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage School Types',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'School Types',
        icon: Icons.check_circle,
        route: RoutePaths.schoolTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add School Types',
        icon: Icons.add_circle,
        route: RoutePaths.schoolTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Academic Grades',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Academic Grades',
        icon: Icons.check_circle,
        route: RoutePaths.academicGrades,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Academic Grades',
        icon: Icons.remove_circle,
        route: RoutePaths.academicGradeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage States',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'States',
        icon: Icons.check_circle,
        route: RoutePaths.states,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add State',
        icon: Icons.add_circle,
        route: RoutePaths.stateForm,
        submenu: [],
      ),
    ],
  ),
   DrawerItem(
    title: 'Manage Districts',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Districts',
        icon: Icons.check_circle,
        route: RoutePaths.districts,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add District',
        icon: Icons.add_circle,
        route: RoutePaths.districtForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Cities',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Cities',
        icon: Icons.check_circle,
        route: RoutePaths.cities,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add City',
        icon: Icons.add_circle,
        route: RoutePaths.cityForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Area Names',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Area Names',
        icon: Icons.check_circle,
        route: RoutePaths.areaNames,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Area Name',
        icon: Icons.add_circle,
        route: RoutePaths.areaNameForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Zipcodes',
    icon: Icons.menu,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Zipcodes',
        icon: Icons.check_circle,
        route: RoutePaths.zipcodes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Zipcode',
        icon: Icons.add_circle,
        route: RoutePaths.zipcodeForm,
        submenu: [],
      ),
    ],
  ),
];
