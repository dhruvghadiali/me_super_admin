import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ViewSlidableActionWidget extends StatelessWidget {
  const ViewSlidableActionWidget({
    super.key,
    required this.onView,
  });

  final Function onView;

  void onViewPressed() {
    HapticFeedback.heavyImpact();
    onView();
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return SlidableAction(
      onPressed: (context) => onViewPressed(),
      backgroundColor: themeData.eerieBlack as Color,
      foregroundColor: themeData.offWhite as Color,
      icon: Icons.file_open_rounded,
      label: 'View',
    );
  }
}
