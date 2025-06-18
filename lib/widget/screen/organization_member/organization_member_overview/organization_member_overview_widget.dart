import 'package:flutter/material.dart';
import 'package:me_super_admin/model/organization_member/organization_member.dart';
import 'package:me_super_admin/widget/common/school/content_strip_widget.dart';

class OrganizationMemberOverviewWidget extends StatelessWidget {
  const OrganizationMemberOverviewWidget({super.key, required this.organizationMember});

  final OrganizationMember organizationMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentStripWidget(header: 'First Name', content: organizationMember.firstName.isNotEmpty ? organizationMember.firstName : 'N/A'),
        ContentStripWidget(header: 'Last Name', content: organizationMember.lastName.isNotEmpty ? organizationMember.lastName : 'N/A'),
        ContentStripWidget(header: 'Email', content: organizationMember.email.isNotEmpty ? organizationMember.email : 'N/A'),
        ContentStripWidget(header: 'Phone', content: organizationMember.phoneNumber.isNotEmpty ? organizationMember.phoneNumber : 'N/A'),
        ContentStripWidget(header: 'Position', content: organizationMember.position.isNotEmpty ? organizationMember.position : 'N/A'),
        ContentStripWidget(header: 'AadhaarNumber', content: organizationMember.aadhaarNumber.isNotEmpty ? organizationMember.aadhaarNumber : 'N/A'),
        ContentStripWidget(header: 'Address', content: organizationMember.address.isNotEmpty ? organizationMember.address : 'N/A'),
        ContentStripWidget(header: 'State', content: organizationMember.state.name.isNotEmpty ? organizationMember.state.name : 'N/A'),
        ContentStripWidget(header: 'District', content: organizationMember.district.name.isNotEmpty ? organizationMember.district.name : 'N/A'),
        ContentStripWidget(header: 'City', content: organizationMember.city.name.isNotEmpty ? organizationMember.city.name : 'N/A'),
        ContentStripWidget(header: 'Area Name', content: organizationMember.areaName.name.isNotEmpty ? organizationMember.areaName.name : 'N/A'),
        ContentStripWidget(header: 'Zipcode', content: organizationMember.zipcode.zipcode.isNotEmpty ? organizationMember.zipcode.zipcode : 'N/A'),
      ],
    );
  }
}
