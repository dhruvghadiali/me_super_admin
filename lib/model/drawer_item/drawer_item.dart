import 'package:flutter/widgets.dart';

class DrawerItem {
  String title;
  String route;
  IconData icon;
  List<DrawerItem> submenu;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.submenu,
  });
}
