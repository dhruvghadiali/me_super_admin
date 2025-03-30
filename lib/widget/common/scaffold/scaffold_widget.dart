import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: themeData.offWhite),
              child: Text(''),
            ),
            ListTile(
              title: Text(
                'Dashboard',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: themeData.offWhite),
              ),
              onTap: () => Navigator.pushNamed(context, "/dashboard"),
            ),
            ListTile(
              title: Text(
                'Schools',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: themeData.offWhite),
              ),
              onTap: () => Navigator.pushNamed(context, "/schools"),
            ),
            ListTile(
              title: Text(
                'Faculties',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: themeData.offWhite),
              ),
              onTap: () => Navigator.pushNamed(context, "/faculties"),
            ),
            ListTile(
              title: Text(
                'Fees Types',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: themeData.offWhite),
              ),
              onTap: () => Navigator.pushNamed(context, "/fees-types"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeData.offWhite),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: themeData.offWhite),
        ),
      ),
      body: child,
    );
  }
}