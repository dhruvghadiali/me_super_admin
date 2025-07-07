import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class SchoolInformationWidget extends StatelessWidget {
  const SchoolInformationWidget({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text(title, maxLines: 2, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite))),
            Expanded(
              flex: 2,
              child: Text(
                description,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
