import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class EditSlidableActionWidget extends StatelessWidget {
  const EditSlidableActionWidget({
    super.key,
    required this.onEdit,
  });

  final Function onEdit;

  void onEditPressed() {
    HapticFeedback.heavyImpact();
    onEdit();
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return SlidableAction(
      onPressed: (context) => onEditPressed(),
      backgroundColor: themeData.calPolyPomonaGreen as Color,
      foregroundColor: themeData.offWhite as Color,
      icon: Icons.edit,
      label: 'Edit',
    );
  }
}
