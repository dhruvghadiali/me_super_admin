import 'package:flutter/material.dart';
import 'package:me_super_admin/model/school_admin/school_admin.dart';
import 'package:me_super_admin/widget/common/school/content_strip_widget.dart';

class SchoolAdminOverviewWidget extends StatelessWidget {
  const SchoolAdminOverviewWidget({super.key, required this.schoolAdmin});

  final SchoolAdmin schoolAdmin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentStripWidget(header: 'First Name', content: schoolAdmin.firstName.isNotEmpty ? schoolAdmin.firstName : 'N/A'),
        ContentStripWidget(header: 'Last Name', content: schoolAdmin.lastName.isNotEmpty ? schoolAdmin.lastName : 'N/A'),
        ContentStripWidget(header: 'Email', content: schoolAdmin.email.isNotEmpty ? schoolAdmin.email : 'N/A'),
        ContentStripWidget(header: 'Phone', content: schoolAdmin.phoneNumber.isNotEmpty ? schoolAdmin.phoneNumber : 'N/A'),
        ContentStripWidget(header: 'Username', content: schoolAdmin.username.isNotEmpty ? schoolAdmin.username : 'N/A'),
      ],
    );
  }
}
