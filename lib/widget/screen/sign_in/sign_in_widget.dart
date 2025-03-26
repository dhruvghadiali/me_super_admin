import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/sign_in/sign_in_form/sign_in_form_widget.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    return SafeArea(
      child: Container(
        color: themeData.eerieBlack,
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            SignInFormWidget(),
          ],
        ),
      ),
    );
  }
}
