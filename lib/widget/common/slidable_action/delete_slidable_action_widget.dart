import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class DeleteSlidableActionWidget extends StatelessWidget {
  const DeleteSlidableActionWidget({
    super.key,
    required this.onDelete,
  });

  final Function onDelete;

  void onDeletePressed() {
    HapticFeedback.heavyImpact();
    onDelete();
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
      onPressed: (context) => onDeletePressed(),
      backgroundColor: themeData.metallicRed as Color,
      foregroundColor: themeData.offWhite as Color,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}
