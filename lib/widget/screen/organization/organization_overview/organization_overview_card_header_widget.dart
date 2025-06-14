import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form_fields/icon_button/icon_button_widget.dart';

class OrganizationOverviewCardHeaderWidget extends StatelessWidget {
  const OrganizationOverviewCardHeaderWidget({super.key, required this.isNewRecord});

  final bool isNewRecord;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "Organization Information".toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themeData.offWhite, fontWeight: FontWeight.bold),
          ),
        ),
        isNewRecord
            ? Container()
            : IconButtonWidget(
              iconData: Icons.edit_document,
              iconColor: themeData.offWhite!,
              onPressed: () => Navigator.pushNamed(context, RoutePaths.organizationForm),
            ),
      ],
    );
  }
}
