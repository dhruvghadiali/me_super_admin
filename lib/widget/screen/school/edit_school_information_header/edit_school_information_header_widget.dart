import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/school/edit_school_information_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/screen/school/edit_school_information_header/edit_school_information_header_button_widget.dart';

class EditSchoolInformationHeaderWidget extends StatelessWidget {
  const EditSchoolInformationHeaderWidget({super.key, required this.currentHeader});

  final EditSchoolInformationHeader currentHeader;

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    return GetBuilder<EditSchoolInformationController>(
      builder: (editSchoolInformationControllerContext) {
        return Card(
          color: themeData.eerieBlack,
          shadowColor: themeData.eerieBlack,
          elevation: 10,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditSchoolInformationHeaderButtonWidget(
                    buttonText: "Organization",
                    isActive: currentHeader == EditSchoolInformationHeader.organization,
                    iconData: Icons.apartment,
                    onClicked: () => editSchoolInformationControllerContext.setCurrentHeader(EditSchoolInformationHeader.organization),
                  ),
                  EditSchoolInformationHeaderButtonWidget(
                    buttonText: "Organization Members",
                    isActive: currentHeader == EditSchoolInformationHeader.organizationMembers,
                    iconData: Icons.people_alt_sharp,
                    onClicked: () => editSchoolInformationControllerContext.setCurrentHeader(EditSchoolInformationHeader.organizationMembers),
                  ),
                  EditSchoolInformationHeaderButtonWidget(
                    buttonText: "School",
                    isActive: currentHeader == EditSchoolInformationHeader.school,
                    iconData: Icons.school,
                    onClicked: () => editSchoolInformationControllerContext.setCurrentHeader(EditSchoolInformationHeader.school),
                  ),
                  EditSchoolInformationHeaderButtonWidget(
                    buttonText: "School Address",
                    isActive: currentHeader == EditSchoolInformationHeader.schoolAddress,
                    iconData: Icons.pin_drop_rounded,
                    onClicked: () => editSchoolInformationControllerContext.setCurrentHeader(EditSchoolInformationHeader.schoolAddress),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
