import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/drawer_items.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
                                      () => Navigator.pushNamed(
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
                      onTap: () => Navigator.pushNamed(context, item.route),
                    ),
          ),
        ],
      ),
    );
  }
}
