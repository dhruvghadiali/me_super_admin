import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/screens/school/school_screen.dart';
import 'package:me_super_admin/screens/sign_in/sign_in_screen.dart';
import 'package:me_super_admin/screens/facility/facility_screen.dart';
import 'package:me_super_admin/screens/fee_type/fee_type_screen.dart';
import 'package:me_super_admin/utils/theme_data/theme_data_util.dart';
import 'package:me_super_admin/screens/dashboard/dashboard_screen.dart';
import 'package:me_super_admin/screens/school_type/school_type_screen.dart';

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
        '/schools': (context) => const SchoolScreen(),
        '/faculties': (context) => const FacilityScreen(),
        '/fees-types': (context) => const FeeTypeScreen(),
        RoutePaths.schoolTypes: (context) => const SchoolTypeScreen(),
        RoutePaths.schoolTypesRegistration: (context) => const FeeTypeScreen(),
      },
    );
  }
}
