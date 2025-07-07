import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/controller/organization/organization_controller.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/controller/school/edit_school_information_controller.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';

import 'package:me_super_admin/model/academic_class/academic_class.dart';
import 'package:me_super_admin/model/organization/organization.dart';
import 'package:me_super_admin/model/organization_member/organization_member.dart';
import 'package:me_super_admin/model/school/school.dart';
import 'package:me_super_admin/model/school_address/school_address.dart';
import 'package:me_super_admin/model/school_admin/school_admin.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/alert/delete_alert_widget.dart';
import 'package:me_super_admin/controller/academic_class/academic_class_controller.dart';
import 'package:me_super_admin/widget/screen/academic_class/academic_class_card_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/edit_slidable_action_widget.dart';
import 'package:me_super_admin/widget/common/slidable_action/delete_slidable_action_widget.dart';
import 'package:me_super_admin/widget/screen/school/school_card_widget.dart';

class SchoolListViewWidget extends StatelessWidget {
  const SchoolListViewWidget({
    super.key,
    required this.onRefresh,
    required this.schools,
    required this.isActiveData,
  });

  final Function onRefresh;
  final List<School> schools;
  final bool isActiveData;

  Future<void> deleteSchool({required BuildContext context, required School school}) async {
    final SchoolController schoolController = Get.put(SchoolController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteAlertWidget(
          onDelete: () {
            schoolController.deleteSchool(school.id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> editSchool({required BuildContext context, required School school}) async {
    final EditSchoolInformationController editSchoolInformationController = Get.put(
      EditSchoolInformationController(),
    );
    final SchoolController schoolController = Get.put(SchoolController());
    final OrganizationController organizationController = Get.put(OrganizationController());
    final OrganizationMemberController organizationMemberController = Get.put(
      OrganizationMemberController(),
    );
    final SchoolAddressController schoolAddressController = Get.put(SchoolAddressController());
    final SchoolAdminController schoolAdminController = Get.put(SchoolAdminController());
    final schoolInfo = schoolController.schoolDetails.firstWhere(
      (element) => element['id'] == school.id,
    );

    StateController stateController = Get.put(StateController());
    stateController.getStates();
    DistrictController districtController = Get.put(DistrictController());
    districtController.getDistricts();
    CityController cityController = Get.put(CityController());
    cityController.getCities();
    AreaNameController areaNameController = Get.put(AreaNameController());
    areaNameController.getAreaNames();
    ZipcodeController zipcodeController = Get.put(ZipcodeController());
    zipcodeController.getZipcodes();

    editSchoolInformationController.setCurrentHeader(EditSchoolInformationHeader.organization);

    if (schoolInfo.containsKey('organization')) {
      final Organization organization = Organization.fromJson(schoolInfo['organization']);
      organizationController.setOrganizationForm(organization);

      if (schoolInfo['organization'].containsKey('organization_members')) {
        final List<OrganizationMember> organizationMembers =
            schoolInfo['organization']['organization_members'] != null
                ? (schoolInfo['organization']['organization_members'] as List)
                    .map((member) => OrganizationMember.fromJson(member))
                    .toList()
                : [];
        organizationMemberController.setOrganizationMembersForm(organizationMembers);
      }
    }

    if (schoolInfo.containsKey('school_address')) {
      final List<SchoolAdmin> schoolAdmins = [];
      final List<SchoolAddress> schoolAddresses =
          schoolInfo['school_address'] != null
              ? (schoolInfo['school_address'] as List).map((address) {
                if (address.containsKey('user')) {
                  schoolAdmins.add(SchoolAdmin.fromJson(address['user']));
                }
                return SchoolAddress.fromJson(address);
              }).toList()
              : [];

      schoolAddressController.setSchoolAddressesForm(schoolAddresses);
      schoolAdminController.setSchoolAdminsForm(schoolAdmins);
    }

    schoolController.setSchoolForm(school);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: themeData.offWhite,
        child: ListView.builder(
          itemCount: schools.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: double.infinity,
              child: Slidable(
                key: ValueKey(UniqueKey()),
                endActionPane: ActionPane(
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  children: [
                    EditSlidableActionWidget(
                      onEdit: () => editSchool(context: context, school: schools[index]),
                    ),
                    DeleteSlidableActionWidget(
                      onDelete: () => deleteSchool(context: context, school: schools[index]),
                    ),
                  ],
                ),
                child: SchoolCardWidget(school: schools[index], isActiveData: isActiveData),
              ),
            );
          },
        ),
      ),
    );
  }
}
