import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key, required this.iconData, required this.iconColor, required this.onPressed});

  final Function onPressed;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => onPressed(), icon: Icon(iconData, color: iconColor));
  }
}
