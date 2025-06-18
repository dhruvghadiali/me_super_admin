import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/drawer_items.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/controller/fee_type/fee_type_controller.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/controller/organization/organization_controller.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/controller/school/school_form_stepper_controller.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/controller/academic_grade/academic_grade_controller.dart';
import 'package:me_super_admin/controller/education_board/education_board_controller.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  void getStates() {
    StateController stateController = Get.put(StateController());
    stateController.getStates();
  }

  void getDistricts() {
    DistrictController districtController = Get.put(DistrictController());
    districtController.getDistricts();
  }

  void getCities() {
    CityController cityController = Get.put(CityController());
    cityController.getCities();
  }

  void getAreaNames() {
    AreaNameController areaNameController = Get.put(AreaNameController());
    areaNameController.getAreaNames();
  }

  void getZipcodes() {
    ZipcodeController zipcodeController = Get.put(ZipcodeController());
    zipcodeController.getZipcodes();
  }

  void getSchoolTypes() {
    SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
    schoolTypeController.getSchoolTypes();
  }

  void getEducationBoards() {
    EducationBoardController educationBoardController = Get.put(EducationBoardController());
    educationBoardController.getEducationBoards();
  }

  void resetSchoolTypeFormValues() {
    SchoolTypeController schoolTypeController = Get.put(SchoolTypeController());
    schoolTypeController.resetSchoolTypeForm();
  }

  void resetAcademicGradeFormValues() {
    AcademicGradeController academicGradeController = Get.put(AcademicGradeController());
    academicGradeController.resetAcademicGradeForm();
  }

  void resetEductionBoardFormValues() {
    EducationBoardController educationBoardController = Get.put(EducationBoardController());
    educationBoardController.resetEducationBoardForm();
  }

  void resetFeeTypeFormValues() {
    FeeTypeController feeTypeController = Get.put(FeeTypeController());
    feeTypeController.resetFeeTypeForm();
  }

  void resetStateFormValues() {
    StateController stateController = Get.put(StateController());
    stateController.resetStateForm();
  }

  void resetDistrictFormValues() {
    DistrictController districtController = Get.put(DistrictController());
    districtController.resetDistrictForm();
    getStates();
  }

  void resetCityFormValues() {
    CityController cityController = Get.put(CityController());
    cityController.resetCityForm();
    getStates();
    getDistricts();
  }

  void resetAreaNameFormValues() {
    AreaNameController areaNameController = Get.put(AreaNameController());
    areaNameController.resetAreaNameForm();
    getStates();
    getDistricts();
    getCities();
  }

  void resetZipcodeFormValues() {
    ZipcodeController zipcodeController = Get.put(ZipcodeController());
    zipcodeController.resetZipcodeForm();
    getStates();
    getDistricts();
    getCities();
    getAreaNames();
  }

  void resetSchoolFormValues() {
    OrganizationController organizationController = Get.put(OrganizationController());
    OrganizationMemberController organizationMemberController = Get.put(OrganizationMemberController());
    SchoolAddressController schoolAddressController = Get.put(SchoolAddressController());
    SchoolAdminController schoolAdminController = Get.put(SchoolAdminController());
    SchoolController schoolController = Get.put(SchoolController());
    SchoolFormStepperController schoolFormStepperController = Get.put(SchoolFormStepperController());

    getStates();
    getCities();
    getZipcodes();
    getAreaNames();
    getDistricts();
    getSchoolTypes();
    getEducationBoards();

    schoolFormStepperController.resetStepper();
    organizationController.resetOrganizationForm();
    organizationMemberController.resetOrganizationMemberForm();
    schoolController.resetSchoolForm();
    schoolAddressController.resetSchoolAddressForm();
    schoolAdminController.resetSchoolAdminForm();
  }

  void onDrawerClick(BuildContext context, String route) {
    switch (route) {
      case RoutePaths.schoolTypeForm || RoutePaths.schoolTypes:
        resetSchoolTypeFormValues();
        break;
      case RoutePaths.academicGradeForm || RoutePaths.academicGrades:
        resetAcademicGradeFormValues();
        break;
      case RoutePaths.educationBoardForm || RoutePaths.educationBoards:
        resetEductionBoardFormValues();
        break;
      case RoutePaths.feeTypeForm || RoutePaths.feeTypes:
        resetFeeTypeFormValues();
        break;
      case RoutePaths.stateForm || RoutePaths.states:
        resetStateFormValues();
        break;
      case RoutePaths.districtForm || RoutePaths.districts:
        resetDistrictFormValues();
        break;
      case RoutePaths.cityForm || RoutePaths.cities:
        resetCityFormValues();
        break;
      case RoutePaths.areaNameForm || RoutePaths.areaNames:
        resetAreaNameFormValues();
        break;
      case RoutePaths.zipcodeForm || RoutePaths.zipcodes:
        resetZipcodeFormValues();
        break;
      case RoutePaths.schoolForm:
        resetSchoolFormValues();
        break;
      default:
        break;
    }

    Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(decoration: BoxDecoration(color: themeData.offWhite), child: Text('')),
          ...drawerItems.map(
            (item) =>
                item.submenu.isNotEmpty
                    ? ExpansionTile(
                      collapsedIconColor: themeData.offWhite,
                      iconColor: themeData.offWhite,
                      leading: Icon(item.icon, color: themeData.offWhite),
                      title: Text(item.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themeData.offWhite)),
                      children:
                          item.submenu
                              .map(
                                (submenuItem) => ListTile(
                                  contentPadding: EdgeInsets.only(left: 50),
                                  leading: Icon(submenuItem.icon, color: themeData.offWhite, size: 20),
                                  title: Text(submenuItem.title, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: themeData.offWhite)),
                                  onTap: () => onDrawerClick(context, submenuItem.route),
                                ),
                              )
                              .toList(),
                    )
                    : ListTile(
                      iconColor: themeData.offWhite,
                      leading: Icon(item.icon, color: themeData.offWhite),
                      title: Text(item.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themeData.offWhite)),
                      onTap: () => onDrawerClick(context, item.route),
                    ),
          ),
        ],
      ),
    );
  }
}
