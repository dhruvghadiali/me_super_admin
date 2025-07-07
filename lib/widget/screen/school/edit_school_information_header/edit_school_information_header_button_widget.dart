import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class EditSchoolInformationHeaderButtonWidget extends StatelessWidget {
  const EditSchoolInformationHeaderButtonWidget({super.key, required this.isActive, required this.buttonText, required this.iconData, required this.onClicked});

  final bool isActive;
  final String buttonText;
  final IconData iconData;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return InkWell(
      onTap: () => onClicked(),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(5),
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: isActive ? themeData.metallicRed!.withValues(alpha: 0.5) : themeData.offWhite!.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(iconData, color: themeData.offWhite as Color),
            ),
            Text(
              buttonText,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: themeData.offWhite),
            ),
          ],
        ),
      ),
    );
  }
}
