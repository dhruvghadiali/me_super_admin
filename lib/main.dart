import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/screens/city/city_screen.dart';
import 'package:me_super_admin/screens/state/state_screen.dart';
import 'package:me_super_admin/screens/school/school_screen.dart';
import 'package:me_super_admin/screens/city/city_form_screen.dart';
import 'package:me_super_admin/screens/sign_in/sign_in_screen.dart';
import 'package:me_super_admin/screens/zipcode/zipcode_screen.dart';
import 'package:me_super_admin/screens/state/state_form_screen.dart';
import 'package:me_super_admin/screens/district/district_screen.dart';
import 'package:me_super_admin/screens/facility/facility_screen.dart';
import 'package:me_super_admin/screens/fee_type/fee_type_screen.dart';
import 'package:me_super_admin/utils/theme_data/theme_data_util.dart';
import 'package:me_super_admin/screens/school/school_form_screen.dart';
import 'package:me_super_admin/screens/dashboard/dashboard_screen.dart';
import 'package:me_super_admin/screens/area_name/area_name_screen.dart';
import 'package:me_super_admin/screens/zipcode/zipcode_form_screen.dart';
import 'package:me_super_admin/screens/district/district_form_screen.dart';
import 'package:me_super_admin/screens/fee_type/fee_type_form_screen.dart';
import 'package:me_super_admin/screens/school_type/school_type_screen.dart';
import 'package:me_super_admin/screens/area_name/area_name_form_screen.dart';
import 'package:me_super_admin/screens/school_type/school_type_form_screen.dart';
import 'package:me_super_admin/screens/academic_grade/academic_grade_screen.dart';
import 'package:me_super_admin/screens/education_board/education_board_screen.dart';
import 'package:me_super_admin/screens/academic_grade/academic_grade_form_screen.dart';
import 'package:me_super_admin/screens/education_board/education_board_form_screen.dart';
import 'package:me_super_admin/screens/admission_document/admission_document_screen.dart';
import 'package:me_super_admin/screens/admission_document/admission_document_form_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MeSuperAdminApp());
}

class MeSuperAdminApp extends StatelessWidget {
  const MeSuperAdminApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ME',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeDataUtil.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInScreen(),
        '/sign-in': (context) => const SignInScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/faculties': (context) => const FacilityScreen(),
        RoutePaths.schools: (context) => const DashboardScreen(),
        RoutePaths.schoolForm: (context) => SchoolFormScreen(),
        RoutePaths.feeTypes: (context) => const FeeTypeScreen(),
        RoutePaths.feeTypeForm: (context) => const FeeTypeFormScreen(),
        RoutePaths.schoolTypes: (context) => const SchoolTypeScreen(),
        RoutePaths.schoolTypeForm: (context) => SchoolTypeFormScreen(),
        RoutePaths.educationBoards: (context) => const EducationBoardScreen(),
        RoutePaths.educationBoardForm: (context) => EducationBoardFormScreen(),
        RoutePaths.academicGrades: (context) => const AcademicGradeScreen(),
        RoutePaths.academicGradeForm: (context) => AcademicGradeFormScreen(),
        RoutePaths.admissionDocuments: (context) => const AdmissionDocumentScreen(),
        RoutePaths.admissionDocumentForm: (context) => AdmissionDocumentFormScreen(),
        RoutePaths.states: (context) => StateScreen(),
        RoutePaths.stateForm: (context) => StateFormScreen(),
        RoutePaths.districts: (context) => DistrictScreen(),
        RoutePaths.districtForm: (context) => DistrictFormScreen(),
        RoutePaths.cities: (context) => CityScreen(),
        RoutePaths.cityForm: (context) => CityFormScreen(),
        RoutePaths.areaNames: (context) => AreaNameScreen(),
        RoutePaths.areaNameForm: (context) => AreaNameFormScreen(),
        RoutePaths.zipcodes: (context) => ZipcodeScreen(),
        RoutePaths.zipcodeForm: (context) => ZipcodeFormScreen(),
      },
    );
  }
}
