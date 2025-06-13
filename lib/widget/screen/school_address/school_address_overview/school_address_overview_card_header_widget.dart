import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form_fields/icon_button/icon_button_widget.dart';

class SchoolAddressOverviewCardHeaderWidget extends StatelessWidget {
  const SchoolAddressOverviewCardHeaderWidget({super.key, required this.isNewRecord, required this.index});

  final bool isNewRecord;
  final int index;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "Address $index".toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold),
          ),
        ),
        isNewRecord
            ? Container()
            : Row(
              children: [
                IconButtonWidget(iconData: Icons.edit_document, iconColor: themeData.offWhite!, onPressed: () {}),
                IconButtonWidget(iconData: Icons.delete, iconColor: themeData.offWhite!, onPressed: () {}),
              ],
            ),
      ],
    );
  }
}
