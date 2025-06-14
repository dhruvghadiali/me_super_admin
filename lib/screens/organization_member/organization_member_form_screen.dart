import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/screen/organization_member/organization_member_form_widget.dart';

class OrganizationMemberFormScreen extends StatelessWidget {
  const OrganizationMemberFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Member', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Theme.of(context).extension<ExtensionsThemeData>()?.offWhite ?? Colors.green, // Change back icon color
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: GetBuilder<OrganizationMemberController>(
          builder: (organizationMemberControllerContext) {
            return SingleChildScrollView(
              child:
                  organizationMemberControllerContext.organizationFormIndex > organizationMemberControllerContext.organizationMembers.length - 1
                      ? const Text('No organization member form available.')
                      : OrganizationMemberFormWidget(
                        index: organizationMemberControllerContext.organizationFormIndex,
                        onSubmitForm: (bool isFormValidated) {
                          if (isFormValidated) {
                            organizationMemberControllerContext.putOrganizationMember();
                          }
                        },
                        isStepper: false,
                        organizationMember: organizationMemberControllerContext.organizationMembers[organizationMemberControllerContext.organizationFormIndex],
                      ),
            );
          },
        ),
      ),
    );
  }
}
