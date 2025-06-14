import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class AuditTrailWidget extends StatelessWidget {
  const AuditTrailWidget({
    super.key,
    required this.audioUserInfo,
    required this.audioInfoLabel,
    required this.auditDateTimeInfo,
    required this.audioDateTimeInfoLabel,
  });

  final String audioUserInfo;
  final String audioInfoLabel;
  final String auditDateTimeInfo;
  final String audioDateTimeInfoLabel;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  audioInfoLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
              Expanded(
                child: Text(
                  audioUserInfo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  audioDateTimeInfoLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
              Expanded(
                child: Text(
                  auditDateTimeInfo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: themeData.offWhite),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
