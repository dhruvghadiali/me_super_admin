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
    icon: Icons.supervised_user_circle_rounded,
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
        route: RoutePaths.schoolForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Facility Types',
    icon: Icons.merge_type_sharp,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Facility Types',
        icon: Icons.folder,
        route: RoutePaths.feeTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Facility Type',
        icon: Icons.add_circle,
        route: RoutePaths.feeTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Faculties',
    icon: Icons.home_repair_service_sharp,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Facilities',
        icon: Icons.folder,
        route: RoutePaths.feeTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Facility',
        icon: Icons.add_circle,
        route: RoutePaths.feeTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Fee Types',
    icon: Icons.currency_rupee,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Fee Types',
        icon: Icons.folder,
        route: RoutePaths.feeTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Fee Type',
        icon: Icons.add_circle,
        route: RoutePaths.feeTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Admission Documents',
    icon: Icons.description,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Admission Documents',
        icon: Icons.folder,
        route: RoutePaths.admissionDocuments,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Admission Document',
        icon: Icons.add_circle,
        route: RoutePaths.admissionDocumentForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Eduction Boards',
    icon: Icons.import_contacts,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Eduction Boards',
        icon: Icons.folder,
        route: RoutePaths.educationBoards,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Eduction Board',
        icon: Icons.add_circle,
        route: RoutePaths.educationBoardForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage School Types',
    icon: Icons.school_rounded,
    route: '',
    submenu: [
      DrawerItem(
        title: 'School Types',
        icon: Icons.folder,
        route: RoutePaths.schoolTypes,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add School Type',
        icon: Icons.add_circle,
        route: RoutePaths.schoolTypeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage Academic Grades',
    icon: Icons.emoji_events,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Academic Grades',
        icon: Icons.folder,
        route: RoutePaths.academicGrades,
        submenu: [],
      ),
      DrawerItem(
        title: 'Add Academic Grade',
        icon: Icons.add_circle,
        route: RoutePaths.academicGradeForm,
        submenu: [],
      ),
    ],
  ),
  DrawerItem(
    title: 'Manage States',
    icon: Icons.map,
    route: '',
    submenu: [
      DrawerItem(
        title: 'States',
        icon: Icons.folder,
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
    icon: Icons.account_balance,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Districts',
        icon: Icons.folder,
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
    icon: Icons.business,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Cities',
        icon: Icons.folder,
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
    icon: Icons.location_city_outlined,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Area Names',
        icon: Icons.folder,
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
    icon: Icons.location_on_outlined,
    route: '',
    submenu: [
      DrawerItem(
        title: 'Zipcodes',
        icon: Icons.folder,
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
