import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class PrimaryDetailCardWidget extends StatelessWidget {
  const PrimaryDetailCardWidget({
    super.key,
    required this.isActive,
    required this.child,
  });

  final bool isActive;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return Card(
      elevation: 2,
      color: themeData.eerieBlack,
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color:
                    isActive
                        ? themeData.calPolyPomonaGreen as Color
                        : themeData.metallicRed as Color,
                width: 5,
              ),
            ),
          ),
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
