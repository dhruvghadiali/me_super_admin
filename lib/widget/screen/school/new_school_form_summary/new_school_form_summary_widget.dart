import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:tab_container/tab_container.dart';
import 'package:me_super_admin/controller/school/school_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/controller/organization/organization_controller.dart';
import 'package:me_super_admin/controller/school/school_form_stepper_controller.dart';
import 'package:me_super_admin/controller/school_address/school_address_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_card_widget.dart';
import 'package:me_super_admin/widget/screen/school/new_school_form_summary/new_school_form_summary_tab_title_widget.dart';

/*
 * Widget: NewSchoolFormSummaryWidget
 * ----------------------------------
 * The main widget for the new school form summary screen.
 * Provides tabbed navigation for different summary sections (organization, members, school, etc.).
 * Manages tab state and controller initialization.
 *
 * State:
 *   - _tabController: Controls the active tab.
 *   - _currentIndex: Tracks the current tab index.
 *   - Controllers for school, admin, organization, address, and members.
 */
class NewSchoolFormSummaryWidget extends StatefulWidget {
  const NewSchoolFormSummaryWidget({super.key});

  @override
  State<NewSchoolFormSummaryWidget> createState() => _NewSchoolFormSummaryWidgetState();
}

class _NewSchoolFormSummaryWidgetState extends State<NewSchoolFormSummaryWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

  SchoolController schoolController = SchoolController();
  SchoolAdminController schoolAdminController = SchoolAdminController();
  OrganizationController organizationController = OrganizationController();
  SchoolAddressController schoolAddressController = SchoolAddressController();
  OrganizationMemberController organizationMemberController = OrganizationMemberController();

  @override
  void initState() {
    /*
     * Initializes the tab controller and sets up a listener to update the current tab index.
     */
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    /*
     * Disposes the tab controller when the widget is removed from the widget tree.
     */
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.topLeft,
            child: Text(
              appLocalizations.newSchoolSummaryHeaderText.toUpperCase(),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: themeData.eerieBlack, fontWeight: FontWeight.bold),
            ),
          ),
          TabContainer(
            controller: _tabController,
            color: themeData.eerieBlack,
            tabs: [
              NewSchoolFormSummaryTabTitleWidget(title: appLocalizations.newSchoolSummaryOrganizationTabLabelText.toUpperCase(), isActive: _currentIndex == 0),
              NewSchoolFormSummaryTabTitleWidget(title: appLocalizations.newSchoolSummarySchoolTabLabelText.toUpperCase(), isActive: _currentIndex == 1),
            ],
            children: [
              NewSchoolFormSummaryTabCardWidget(
                showOrganization: true,
                showOrganizationMembers: true,
                showSchool: false,
                showSchoolAddresses: false,
                showSchoolAdmins: false,
              ),
              NewSchoolFormSummaryTabCardWidget(
                showOrganization: false,
                showOrganizationMembers: false,
                showSchool: true,
                showSchoolAddresses: true,
                showSchoolAdmins: true,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButtonWidget(
                    appColorScheme: AppColorScheme.primary,
                    buttonText: appLocalizations.addButtonText.toUpperCase(),
                    disabled: false,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GetBuilder<SchoolFormStepperController>(
                    builder: (schoolFormStepperControllerContext) {
                      return ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.editButtonText.toUpperCase(),
                        disabled: false,
                        onPressed: () => schoolFormStepperControllerContext.toggleShowSummary(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
