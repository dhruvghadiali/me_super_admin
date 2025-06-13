import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/model/organization/organization.dart';
import 'package:me_super_admin/widget/common/school/content_strip_widget.dart';
import 'package:me_super_admin/controller/organization/organization_controller.dart';

class OrganizationOverviewWidget extends StatelessWidget {
  const OrganizationOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationController>(
      builder: (organizationControllerContext) {
        Organization organization = organizationControllerContext.organization;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentStripWidget(header: 'Name', content: organization.name.isNotEmpty ? organization.name : 'N/A'),
            ContentStripWidget(header: 'Short Name', content: organization.shortName.isNotEmpty ? organization.shortName : 'N/A'),
            ContentStripWidget(header: 'Email', content: organization.email.isNotEmpty ? organization.email : 'N/A'),
            ContentStripWidget(header: 'Phone', content: organization.phoneNumber.isNotEmpty ? organization.phoneNumber : 'N/A'),
            ContentStripWidget(
              header: 'Government Registration Number',
              content: organization.governmentRegistrationNumber.isNotEmpty ? organization.governmentRegistrationNumber : 'N/A',
            ),
            ContentStripWidget(header: 'Address', content: organization.address.isNotEmpty ? organization.address : 'N/A'),
            ContentStripWidget(header: 'State', content: organization.state.name.isNotEmpty ? organization.state.name : 'N/A'),
            ContentStripWidget(header: 'District', content: organization.district.name.isNotEmpty ? organization.district.name : 'N/A'),
            ContentStripWidget(header: 'City', content: organization.city.name.isNotEmpty ? organization.city.name : 'N/A'),
            ContentStripWidget(header: 'Area Name', content: organization.areaName.name.isNotEmpty ? organization.areaName.name : 'N/A'),
            ContentStripWidget(header: 'Zipcode', content: organization.zipcode.zipcode.isNotEmpty ? organization.zipcode.zipcode : 'N/A'),
          ],
        );
      },
    );
  }
}
