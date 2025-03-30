import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class RestoreSlidableActionWidget extends StatelessWidget {
  const RestoreSlidableActionWidget({
    super.key,
    required this.onRestore,
  });

  final Function onRestore;

  void onRestorePressed() {
    HapticFeedback.heavyImpact();
    onRestore();
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return SlidableAction(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      onPressed: (context) => onRestorePressed(),
      backgroundColor: themeData.calPolyPomonaGreen as Color,
      foregroundColor: themeData.offWhite as Color,
      icon: Icons.restore_from_trash_rounded,
      label: 'Restore',
    );
  }
}
