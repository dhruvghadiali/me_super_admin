import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ContentStripWidget extends StatelessWidget {
  const ContentStripWidget({super.key, required this.header, required this.content});

  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(header, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: themeData.offWhite!.withValues(alpha: 0.5), fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(content, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: themeData.offWhite)),
          SizedBox(height: 5),
          Divider(color: themeData.offWhite!.withValues(alpha: 0.1), thickness: 1),
        ],
      ),
    );
  }
}
