import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class AuditTrailWidget extends StatelessWidget {
  const AuditTrailWidget({
    super.key,
    required this.audioUserInfo,
    required this.auditDateTimeInfo,
  });

  final String auditDateTimeInfo;
  final String audioUserInfo;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return Row(
      children: [
        Expanded(
          child: Text(
            audioUserInfo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
          ),
        ),
        Expanded(
          child: Text(
            auditDateTimeInfo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
          ),
        ),
      ],
    );
  }
}
