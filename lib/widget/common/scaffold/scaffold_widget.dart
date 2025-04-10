import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/drawer/drawer_widget.dart';

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
      drawer: DrawerWidget(),
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
