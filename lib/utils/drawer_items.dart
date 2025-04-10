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
        route: '/fee-types/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Fee Types',
        icon: Icons.remove_circle,
        route: '/fee-types/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Fee Types',
        icon: Icons.add_circle,
        route: '/fee-types/register',
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
        title: 'Active Eduction Boards',
        icon: Icons.check_circle,
        route: '/education-boards/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Eduction Boards',
        icon: Icons.remove_circle,
        route: '/education-boards/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Eduction Boards',
        icon: Icons.add_circle,
        route: '/education-boards/register',
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
        title: 'Register School Types',
        icon: Icons.add_circle,
        route: RoutePaths.schoolTypesRegistration,
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
        title: 'Active Academic Grades',
        icon: Icons.check_circle,
        route: '/academic-grades/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Academic Grades',
        icon: Icons.remove_circle,
        route: '/academic-grades/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Academic Grades',
        icon: Icons.add_circle,
        route: '/academic-grades/register',
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
        title: 'Active States',
        icon: Icons.check_circle,
        route: '/states/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive States',
        icon: Icons.remove_circle,
        route: '/states/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register States',
        icon: Icons.add_circle,
        route: '/states/register',
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
        title: 'Active Cities',
        icon: Icons.check_circle,
        route: '/cities/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Cities',
        icon: Icons.remove_circle,
        route: '/cities/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Cities',
        icon: Icons.add_circle,
        route: '/cities/register',
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
        title: 'Active Zipcodes',
        icon: Icons.check_circle,
        route: '/zipcodes/active',
        submenu: [],
      ),
      DrawerItem(
        title: 'Inactive Zipcodes',
        icon: Icons.remove_circle,
        route: '/zipcodes/inactive',
        submenu: [],
      ),
      DrawerItem(
        title: 'Register Zipcodes',
        icon: Icons.add_circle,
        route: '/zipcodes/register',
        submenu: [],
      ),
    ],
  ),
];
