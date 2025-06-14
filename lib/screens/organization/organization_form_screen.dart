import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/organization/organization_form_widget.dart';

class OrganizationFormScreen extends StatelessWidget {
  const OrganizationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Theme.of(context).extension<ExtensionsThemeData>()?.offWhite ?? Colors.green, // Change back icon color
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: SingleChildScrollView(child: const OrganizationFormWidget(isStepperForm: false)),
      ),
    );
  }
}
